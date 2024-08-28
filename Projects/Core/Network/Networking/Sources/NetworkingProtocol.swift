//
//  NetworkingProtocol.swift
//  Finda
//
//  Created by 엄기철 on 2021/04/19.
//  Copyright © 2021 Finda. All rights reserved.
//

import SystemConfiguration
import UIKit
import Then
import RxSwift
import RxCocoa
import RxMoya
import Moya
import ObjectMapper
import FindaUI
import FindaUtils
import FindaAPIs

public protocol NetworkingDelegate: AnyObject {
    func changePincodeUnLoockView()
}

public protocol NetworkingProtocol {
    var delegate: NetworkingDelegate? { get set }
    func request(_ target: TargetType, file: StaticString, function: StaticString, line: UInt) -> Single<Moya.Response>
}

extension NetworkingProtocol {
    public func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
        return self.request(target, file: file, function: function, line: line)
    }
}

public var defaultErrorMessage: String = "현재 일시적인 문제가 생겨 빠르게 개선중입니다.\n이용에 불편을 드려 죄송합니다.\n잠시 후 다시 접속해주세요."

public final class Networking: MoyaProvider<MultiTarget>, NetworkingProtocol {
    
    public static let shared = Networking(logger: [MoyaAccessTokenPlugin()])
    
    var disposeBag: DisposeBag = DisposeBag()
    let intercepter: ConnectChecker
    public weak var delegate: NetworkingDelegate?
    
    public init(logger: [PluginType]) {
        let intercepter = ConnectChecker()
        self.intercepter = intercepter
        
        let configuration = URLSessionConfiguration.default.then {
            $0.timeoutIntervalForRequest = 60
            $0.urlCache = URLCache(memoryCapacity: 5_000_000, diskCapacity: 0) // memoryCapacity: 5 MB
        }
        
        let session = Session(configuration: configuration, startRequestsImmediately: false)
        
        super.init(requestClosure: { endpoint, completion in
            do {
                let urlRequest = try endpoint.urlRequest()
                intercepter.adapt(urlRequest, for: session, completion: completion)
            } catch MoyaError.requestMapping(let url) {
                completion(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                completion(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }, session: session, plugins: logger)
    }
    
    public func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
        let requestString = "\(target.method.rawValue) \(target.path)"
        
        return self.rx.request(.target(target))
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                let message = "SUCCESS: \(requestString) (\(value.statusCode))"
                log.debug(message, file: file, function: function, line: line)
            }, onError: { error in
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
                        log.warning(message, file: file, function: function, line: line)
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                        log.warning(message, file: file, function: function, line: line)
                    } else {
                        let message = "FAILURE: \(requestString) (\(response.statusCode))"
                        log.warning(message, file: file, function: function, line: line)
                    }
                } else {
                    let message = "FAILURE: \(requestString)\n\(error)"
                    log.debug(message, file: file, function: function, line: line)
                }
                
            }, onSubscribed: {
                let message = "REQUEST: \(requestString)"
                log.debug(message)
            }).catch {
                guard let error = $0 as? MoyaError else {
                    return .error(BaseApiError())
                }
                
                if case let .statusCode(status) = error {
                    
                    guard let errorMessageResponse = try? JSONDecoder().decode(BaseApiError.self, from: status.data) else {
                        return .error(BaseApiError())
                    }
                    
                    if status.statusCode == 500 {
                        return .error(errorMessageResponse)
                        // self.serverIncident()
                    } else if status.statusCode == 401 {
                        if (errorMessageResponse.errorCode == 1201 &&
                            errorMessageResponse.errorReason == "UnAuthorized") ||
                            (errorMessageResponse.errorCode == 1205 &&
                             errorMessageResponse.errorReason == "Expired") ||
                            (errorMessageResponse.rspCode == "40101") {
                            
                            PopupViewController().then {
                                $0.setTitle("개인 정보 보호를 위해\n로그아웃 할게요.")
                                $0.setDescription("안전한 서비스 이용을 위해\n다시 로그인해주세요.")
                                $0.setMainButton(title: "다시 로그인하기", action: {
                                    self.delegate?.changePincodeUnLoockView()
                                })
                            }.show(above: UIApplication.shared.windows.first?.rootViewController)
                            
                            return .error(errorMessageResponse)
                        }
                    } else if status.statusCode == 406 {
                        if errorMessageResponse.errorCode == 1206 ||
                            errorMessageResponse.errorCode == 1208 ||
                            errorMessageResponse.errorCode == 1209 ||
                            errorMessageResponse.errorCode == 1501 {
                            
                            PopupViewController().then {
                                $0.setTitle("비정상적인 접근을 감지했어요.\n보안을 위해 앱을 종료할게요")
                                $0.setMainButton(title: "확인", action: {
                                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
                                })
                                $0.bindBlockErrorGesture()
                            }.show(above: UIApplication.shared.windows.first?.rootViewController)
                            
                            return .error(BaseApiError())
                        }
                    }
                    // 공통 에러 처리
                    return .error(errorMessageResponse)
                }
                
                return .error(BaseApiError())
            }
    }
    
    class ConnectChecker {
        
        init() { }
        
        func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, MoyaError>) -> Void) {
            
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                completion(.success(urlRequest))
                return
            }
            
            var flags: SCNetworkReachabilityFlags = []
            
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                completion(.failure(MoyaError.requestMapping(defaultErrorMessage)))
                return
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            if isReachable && !needsConnection {
                completion(.success(urlRequest))
            } else {
                completion(.failure(MoyaError.requestMapping(defaultErrorMessage)))
                return
            }
        }
    }
}

