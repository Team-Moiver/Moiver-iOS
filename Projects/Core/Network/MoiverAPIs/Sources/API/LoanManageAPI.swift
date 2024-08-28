//
//  LoanManageApi.swift
//  Finda
//
//  Created by jinseon on 2022/02/23.
//  Copyright © 2022 Finda. All rights reserved.
//

import Moya
import ObjectMapper

public enum LoanManageAPI {
  case transactions(startDate: String, endDate: String)
  case overdues
  case loans(cache: Bool, source: Source)
  case putLoan(accountId: Int, param: [String: Any])
  case putLoans(sortOrder: String, list: [[String: Any]])
  case getLoan(accountId: Int, cache: Bool)
  case refresh(orgList: [String])
  case deposits
  case putConnectedAccount(accountId: Int, param: [String: Any])
}

extension LoanManageAPI {
  public enum Source: String {
    case MAIN_HOME = "mainHome"
    case LOAN_MANAGE = "loanManage"
    case LOAN_APPLY = "loanApply"
  }
}

extension LoanManageAPI: BaseAPI {
  public var method: Moya.Method {
    switch self {
    case .transactions, .overdues, .loans, .getLoan, .refresh, .deposits:
      return .get
    case .putLoan, .putLoans, .putConnectedAccount:
      return .put
    }
  }
  
  public var task: Task {
    switch self {
    case .transactions(startDate: let start, endDate: let end):
      let params: [String: Any] = ["startDate": start, "endDate": end]
      let encoding = URLEncoding(destination: .queryString,
                                 arrayEncoding: .noBrackets,
                                 boolEncoding: .numeric)
      return .requestParameters(parameters: params,
                                encoding: encoding)
    case .overdues:
      return .requestPlain
    case .loans(cache: let cache, source: let source):
      let param = ["cache": cache ? "true" : "false", "source": source.rawValue] as [String: Any]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .putLoan(accountId: _, param: let param):
      return .requestParameters(parameters: param, encoding: JSONEncoding.init(options: .fragmentsAllowed))
    case .putLoans(let order, let list):
      let params: [String: Any] = ["sortOrder": order, "list": list]
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case .getLoan(accountId: _, cache: let cache):
      let param = ["cache": cache ? "true" : "false"] as [String: Any]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .refresh(orgList: let list):
      let listString = list.joined(separator: ",")
      let params: [String: Any] = ["orgList": listString]
      let encoding = URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      return .requestParameters(parameters: params, encoding: encoding)
    case .deposits:
      return .requestPlain
    case .putConnectedAccount(accountId: _, param: let params):
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
  
  
  public var baseURL: URL {
    guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
    return url
  }
  
  
  public var path: String {
    switch self {
    case .transactions:
      return "/lms/v1/loanmanage/transactions"
    case .overdues:
      return "/pf/v2/loanmanage/overdues"
    case .loans:
      return "/ams/v1/loanmanage/loans"
    case .putLoan(accountId: let id, param: _):
      return "/lms/v1/loanmanage/loans/\(id)"
    case .getLoan(accountId: let id, cache: _):
      return "/ams/v2/lms/loans/\(id)"
    case .putLoans:
      return "/lms/v1/loanmanage/loans"
    case .refresh:
      return "/ams/v1/lms/loans"
    case .deposits:
      return "/pf/v2/loanmanage/deposits"
    case .putConnectedAccount(accountId: let accountId, param: _):
      return "/ams/v2/lms/loans/\(accountId)"
    }
  }
}
