//
//  SplashAPI.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/18.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation
import Moya

public enum SplashAPI {
    case incident
    case version(request: SplashVersionRequest)
}

extension SplashAPI: BaseAPI {
    
    public var baseURL: URL {
        switch self {
        case .incident:
            guard let url = URL(string: incidentUrl()) else { fatalError("Bad Request incidentURL")}
            return url
        case .version:
            guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
            return url
        }
    }
    
    
    public var path: String {
        switch self {
        case .incident:
            var pathString = ""
#if DEBUG
            pathString = "/stage-findaapp_disable.json"   // prd : "/findaapp_disable.json", stage : "/stage-findaapp_disable.json"
#else
            pathString = "/findaapp_disable.json"
#endif
            return pathString
        case .version:
            return "/account/v1/operation-property"
        }
    }
    
    
    public var method: Moya.Method {
        switch self {
        case .incident, .version:
            return .get
        }
    }
    
    public var task: Task {
        guard let parameters = parameters else { return .requestPlain }
        switch self {
        case .incident:
            return .requestPlain
        case .version:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .version(req):
            return ["name": req.device]
        default:
            return [:]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}

