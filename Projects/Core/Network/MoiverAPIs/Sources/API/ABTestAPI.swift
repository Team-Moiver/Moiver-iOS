//
//  ABTestAPI.swift
//  Finda
//
//  Created by donghyun on 2022/06/27.
//  Copyright © 2022 Finda. All rights reserved.
//

import Foundation
import Moya

public enum ABTestAPI {
    case list(userKey: String)
}

extension ABTestAPI: BaseAPI {
    
    public var path: String {
        switch self {
        case .list(let userkey):
            return "/account/abtest/user/\(userkey)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .list:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .list:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .list:
            return nil
        }
    }
}
