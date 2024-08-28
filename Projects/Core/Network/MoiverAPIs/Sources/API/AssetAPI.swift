//
//  AssetsAPI.swift
//  Finda
//
//  Created by 박영진 on 2021/09/23.
//  Copyright © 2021 Finda. All rights reserved.
//

import Moya

public enum AssetsAPI {
    case car(CarParams)
}

extension AssetsAPI: BaseAPI {
    
    public var path: String {
        switch self {
        case .car: return "/misc/v1/verify/carNumber"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .car: return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .car(let request):
            return .requestParameters(parameters: request.map,
                                      encoding: JSONEncoding.default)
        }
    }
}
