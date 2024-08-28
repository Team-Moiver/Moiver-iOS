//
//  ApiRequest.swift
//  Finda
//
//  Created by ha on 2019/11/15.
//  Copyright © 2019 Finda. All rights reserved.
//

import Foundation
import Alamofire
import FindaUI
import FindaUtils
import UIKit
import Moya

public class ApiRequest {
    
    public static let NETWORK_ERROR_WEBVIEW = "[WKWebView] 일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
    public static let NETWORK_ERROR_COMMON = "네트워크 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
    public static let NETWORK_ERROR_REGISTER_USER = "회원가입에 실패하였습니다.\n잠시 후 다시 시도해주세요."
    public static let NETWORK_ERROR_LOAN_APPLY = "한도조회 요청이 실패하였습니다.\n잠시 후 다시 시도해주세요."
    public static let NETWORK_ERROR_LOAN_APPLY_BZ_NUMBER = "사업자번호 요청이 실패하였습니다.\n잠시 후 다시 시도해주세요."
    public static let NETWORK_ERROR_LOAN_APPLY_SUBMIT = "한도조회 계약 요청이 실패하였습니다.\n잠시 후 다시 시도해주세요."
    
    public var completionHandlers: [() -> Void] = []
    public func withEscaping(completion: @escaping () -> Void) {
        // 함수 밖에 있는 completionHandlers 배열에 해당 클로저를 저장
        completionHandlers.append(completion)
    }
    
    public static var signatureKey: String?
    public static let deviceId = UIDevice.current.identifierForVendor?.uuidString
    public static  let secretKey = parseKeys().secretKey
    public static let version = appVersion()
    
    public static func showErrorMessage(vc: UIViewController, message: String, _ statusCode: Int?) {
        var codeMsg = message
        if statusCode != nil {
            codeMsg += " (\(statusCode!))"
        }
        PopupViewController().then {
            $0.setTitle(NETWORK_ERROR_COMMON)
            $0.setDescription(codeMsg)
            $0.setMainButton(title: "확인", action: {})
        }.show(above: vc)
    }
    
    public static func showErrorCommon(vc: UIViewController, _ statusCode: Int?) {
        
        var codeMsg = ApiRequest.NETWORK_ERROR_COMMON
        if statusCode != nil {
            codeMsg += " (\(statusCode!))"
        }
        PopupViewController().then {
            $0.setTitle("네트워크 오류")
            $0.setDescription(codeMsg)
            $0.setMainButton(title: "확인", action: {})
            $0.setCancelable()
        }.show(above: vc)
    }
    
    
    /////////////////// - GENERIC - /////////////////////////////
    
    public static func fetchDataGeneric<Response: Codable>(url: String, method: HTTPMethod = .get, viewController: UIViewController? = nil, isForLogin: Bool = false, completion: @escaping (Bool, Response?, Int?, String?) -> Void) {
        
        fetchDataGeneric(url: url, parameters: "", method: method, viewController: viewController ?? nil, isForLogin: isForLogin, completion: completion)
    }
    
    
    
    public static func fetchDataGeneric<Response: Codable, Parameters: Codable>(url: String, parameters: Parameters? = nil, method: HTTPMethod = .get, viewController: UIViewController? = nil, isForLogin: Bool = false, completion: @escaping (Bool, Response?, Int?, String?) -> Void) {
        
        var token: String  = ""
        token = UserDefaultManager.shared.userToken ?? ""
        
        var header = HTTPHeaders.default
        if let userAgent = header.value(for: "User-Agent")?.replacingOccurrences(of: "핀다", with: "Finda") {
            header.update(name: "User-Agent", value: userAgent)
        }
        
        if let deviceId = deviceId {
            header.add(name: "X-Client-Device-Id", value: deviceId)
            if signatureKey == nil {
                signatureKey = "\(deviceId)\(secretKey)".md5()
            }
            header.add(name: "X-Signature-V1", value: signatureKey!)
        }
        
        
        header.add(name: "X-Client-App-Os-Type", value: OsType.iOS.rawValue)
        header.add(name: "X-Client-App-Version", value: version)
        header.add(name: "X-Auth-Token", value: token)
        header.add(name: "Cache-Control", value: "no-store")
        
        print("token", token)
        
        var encoderType: ParameterEncoder =  URLEncodedFormParameterEncoder.default
        var paramVal: Parameters?
        var successCode: Int = 200
        
        switch method {
        case .get:
            encoderType = URLEncodedFormParameterEncoder.default
            paramVal = nil
            successCode = 200
            
        case .post:
            encoderType = JSONParameterEncoder.default
            
            paramVal = parameters as? String == "" ? nil : parameters
            
            successCode = 201
            
        case .put:
            encoderType = JSONParameterEncoder.default
            paramVal = parameters as? String == "" ? nil : parameters
            successCode = 200
            
        case .delete:
            encoderType = URLEncodedFormParameterEncoder.default
            paramVal = nil
            successCode = 204
            
        default:
            encoderType = URLEncodedFormParameterEncoder.default
            paramVal = nil
            successCode = 200
        }
        
        if Response.self == Completion.self {
            AF.request(url, method: method, parameters: paramVal, encoder: encoderType, headers: header)
                .responseJSON { response in
                    debugPrint("response", response)
                    
                    completion(response.response?.statusCode == successCode, nil, response.response?.statusCode, nil)
                    return
                }
        } else {
            AF.request(url, method: method, parameters: paramVal, encoder: encoderType, headers: header)
            
                .responseDecodable(of: Response.self) { response in
                    debugPrint("response", response)
                    
                    // 리스폰스 없을때
                    if response.response?.statusCode == 204 {
                        completion(true, response.value, 204, nil)
                        return
                    }
                    
                    if response.response?.statusCode == 500 {
                        completion(false, nil, response.response?.statusCode, nil)
                        if let controller = viewController {
                            showErrorCommon(vc: controller, response.response?.statusCode)
                        }
                        return
                    }
                    
                    switch response.result {
                    case .success:
                        if let statusCode = response.response?.statusCode {
                            if statusCode == successCode || (statusCode / 100 == 2) {
                                completion(true, response.value, statusCode, nil)
                                
                            } else if statusCode == 401 {
                                completion(false, response.value, statusCode, nil)
                            } else {
                                completion(false, nil, statusCode, nil)
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                        completion(false, nil, response.response?.statusCode, nil)
                        if !isForLogin {
                            if let controller = viewController {
                                showErrorCommon(vc: controller, response.response?.statusCode)
                            }
                        }
                    }
                }
        }
    }
    /////////////////// - GENERIC-END  - /////////////////////////////
}



public enum ResponseType: String {
    case encoded = "endcoded"
    case string = "string"
    case response = "response"
}

public enum ApiEncoderType: String {
    case jsonEncoder = "jsonEncoder" // post -> parameters : body 에 등어가는 json Encoder
    case urlEncoder = "urlEncoder" // get -> parameters : Path URL 에 들어가는 URL Encoder
}

public enum HttpMethoType {
    case post
    case put
}
