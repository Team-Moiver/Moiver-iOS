//
//  BaseAPI.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/11.
//  Copyright © 2023 Finda. All rights reserved.
//
import Foundation
import Alamofire
import Moya
import RxOptional

public protocol BaseAPI: TargetType {}

public struct BaseApiError: Error, Codable {
  public var reponseCode: Int?
  public var errorType: String?
  public var errorTarget: String?
  public var errorReason: String?
  public var errorCode: Int?
  public var errorMessage: String?
  public var rspCode: String?
  public var rspMsg: String?
  
  public init() {}
  
  public enum ErrorAction {
    case retry
    case dismiss
    case none
  }
}

extension BaseAPI {
  public var baseURL: URL {
    guard let url = URL(string: baseUrl()) else { fatalError("Bad URL Request") }
    return url
  }
  
  public var headers: [String: String]? {
    return ["User-Agent": HTTPHeaders.default.value(for: "User-Agent")?
      .replacingOccurrences(of: "핀다", with: "Finda") ?? ""]
  }
  
  public var sampleData: Data {
    guard let data = "Data".data(using: String.Encoding.utf8) else { return Data() }
    return data
  }
}

extension BaseApiError: LocalizedError {
  public var errorDescription: String? {
    let msg = (errorMessage ?? "").isNotEmpty ? (errorMessage ?? "") : (rspMsg ?? "")
    return NSLocalizedString(msg.isNotEmpty ? msg : "일시적인 문제로 이용할 수 없습니다.\n잠시 후 다시 시도해 주세요.", comment: "serverError")
  }
}
