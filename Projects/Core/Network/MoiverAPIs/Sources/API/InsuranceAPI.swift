//
//  InsuranceAPI.swift
//  Finda
//
//  Created by 박영진 on 2021/05/20.
//  Copyright © 2021 Finda. All rights reserved.
//

import Moya
import ObjectMapper

public enum InsuranceAPI {
    case resend(Int64)
}

extension InsuranceAPI: BaseAPI {
    
    public var baseURL: URL {
        switch self {
        case .resend:
            guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .resend(let cpiID):
            return "/insurance/v1/cardif/cpi/\(cpiID)/join-message"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .resend:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
}
