//
//  AssetManageAsyncAPI.swift
//  Finda
//
//  Created by jinseon on 2023/06/27.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation
import Moya

public enum AssetManageAsyncAPI {
  case loans
  case checking
  case depositAndSavings
  case cards
  case bill
}

extension AssetManageAsyncAPI: BaseAPI {
  public var path: String {
    switch self {
    case .loans:
      return "/ams/v1/lms/loans-async"
    case .checking:
      return "/ams/v1/dms/checking-async"
    case .depositAndSavings:
      return "/ams/v1/dms/deposit-and-savings-async"
    case .cards:
      return "/ams/v1/cms/cards/transaction-refresh-async"
    case .bill:
      return "/ams/v1/cms/cards/bill-refresh-async"
    }
  }
  
  public var baseURL: URL {
    guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
    return url
  }
  
  public var method: Moya.Method {
    switch self {
    case .loans, .checking, .depositAndSavings, .cards, .bill:
      return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .loans, .checking, .depositAndSavings, .bill:
      let param = ["cache": "false"]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .cards:
      return .requestPlain
    }
  }
}
