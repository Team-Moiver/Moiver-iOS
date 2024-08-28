//
//  NotiAPI.swift
//  Finda
//
//  Created by myunggi on 2021/07/07.
//  Copyright © 2021 Finda. All rights reserved.
//

import Moya
import Foundation

public enum NotiAPI {
    
    /// 사용자 알림 이력 목록 조회(NEW)
    case latestNotification(LatestNotiRequest)
}

extension NotiAPI: BaseAPI {
    
    public var baseURL: URL {
        guard let url = URL(string: baseUrl()) else { fatalError("Bad Request baseURL")}
        return url
    }
    
    public var path: String {
        switch self {
        case .latestNotification:
            return "/noti/v1/notification/list"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .latestNotification:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .latestNotification(let params):
            return .requestParameters(
                parameters: params.toParameters(),
                encoding: URLEncoding.default
            )
        }
    }
}
