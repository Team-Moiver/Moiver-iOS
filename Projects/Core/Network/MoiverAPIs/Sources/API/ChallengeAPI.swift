//
//  ChallengeAPI.swift
//  Finda
//
//  Created by donghyun on 2023/07/14.
//  Copyright © 2023 Finda. All rights reserved.
//

import Moya

public enum ChallengeAPI {
  case perform(eventName: String, properties: [String: Any])
}

extension ChallengeAPI: BaseAPI {
    public var path: String {
        switch self {
        case .perform:
            return "/pcs/challenge/v1/action/perform"
        }
    }
    
    
    public var method: Moya.Method {
        switch self {
        case .perform:
            return .post
        }
    }
    
    public var task: Task {
        guard let parameters = parameters else { return .requestPlain }
        switch self {
        case .perform:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .perform(eventName, properties):
            return [
              "eventName": eventName,
              "properties": properties
            ]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
