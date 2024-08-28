//
//  SingleLineAPI.swift
//  Finda
//
//  Created by jinseon on 2022/08/12.
//  Copyright © 2022 Finda. All rights reserved.
//

import Foundation
import Moya

public enum SingleLineAPI {
    case getSingleLineMessages(type: PopupMessageType)
}

extension SingleLineAPI: BaseAPI {
    
    public var baseURL: URL {
        switch self {
        case .getSingleLineMessages:
            guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL") }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .getSingleLineMessages:
            return "/account/v1/user-single-line-message"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getSingleLineMessages:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getSingleLineMessages(let type):
            return .requestParameters(parameters: ["type": type.rawValue], encoding: URLEncoding.queryString)
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
}
