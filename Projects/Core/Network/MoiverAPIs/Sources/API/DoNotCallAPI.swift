//
//  DoNotCallAPI.swift
//  Finda
//
//  Created by 엄기철 on 2021/05/18.
//  Copyright © 2021 Finda. All rights reserved.
//

import Moya
import ObjectMapper

public enum DoNotCallAPI {
    case doNotCallEnrollment
    case doNotCallCheck
    case termsSearch(serviceName: String)
    case termsEnrollment(TermsEnrollmentRequest)
}

extension DoNotCallAPI: BaseAPI {
    
    public var baseURL: URL {
        guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
        return url
    }
    
    public var path: String {
        switch self {
        case .doNotCallEnrollment:
            return "/idcert/v1/donotcall/application"
        case .doNotCallCheck:
            return "/idcert/v1/donotcall/application/check"
        case .termsSearch(let serviceName):
            return "/account/v1/terms/services/\(serviceName)"
        case .termsEnrollment:
            return "/account/v1/terms/services/\("donotcall")/agreements"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .doNotCallCheck, .termsSearch:
            return .get
        case .doNotCallEnrollment, .termsEnrollment:
            return .post
        }
    }
    
    public var task: Task {
        guard let parameters = parameters else { return .requestPlain }
        switch self {
        case .doNotCallCheck, .termsSearch:
            return .requestPlain
        case .doNotCallEnrollment:
            return .requestCompositeParameters(bodyParameters: parameters,
                                               bodyEncoding: parameterEncoding,
                                               urlParameters: parameters)
        case let .termsEnrollment(dto):
            return .requestJSONEncodable(dto.agreements)
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .doNotCallCheck, .doNotCallEnrollment, .termsSearch, .termsEnrollment:
            return [:]
        }
    }
    
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .doNotCallCheck, .termsSearch:
            return URLEncoding.queryString
        case .doNotCallEnrollment, .termsEnrollment:
            return JSONEncoding.default
        }
    }
}
