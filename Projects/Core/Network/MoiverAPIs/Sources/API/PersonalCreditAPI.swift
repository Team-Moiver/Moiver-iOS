//
//  PersonalCreditAPI.swift
//  Finda
//
//  Created by 박영진 on 2021/08/03.
//  Copyright © 2021 Finda. All rights reserved.
//

import Foundation
import Moya

public enum PersonalCreditAPI {
  case kcb(KCBParams)
  case scoreHistory
  case changedHistory
  case newKcb(KCBParams)
  case overdueList
}

extension PersonalCreditAPI: BaseAPI {
    
    public var path: String {
        switch self {
        case .newKcb: return "/credit/v1/personalcredit/kcb-data"
        case .kcb: return "/pf/v2/personalcredit/kcb-data"
        case .scoreHistory: return "/credit/v1/kcb/credit-score-history"
        case .changedHistory: return "/credit/v1/kcb/changed-history"
        case .overdueList: return "/credit/v1/kcb/overdue-list"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .kcb, .scoreHistory, .newKcb, .overdueList: return .get
        case .changedHistory: return .post
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
        return url
    }
    
    public var task: Task {
        switch self {
        case .kcb(let request):
            return .requestParameters(parameters: request.map,
                                      encoding: URLEncoding.queryString)
        case .newKcb(let request):
            return .requestParameters(parameters: request.map,
                                      encoding: URLEncoding.queryString)
        case .scoreHistory, .changedHistory, .overdueList:
          return .requestPlain
        }
    }
}
