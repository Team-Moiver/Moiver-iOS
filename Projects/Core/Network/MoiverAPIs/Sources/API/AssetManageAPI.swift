//
//  AssetManageAPI.swift
//  Finda
//
//  Created by jinseon on 2022/12/28.
//  Copyright © 2022 Finda. All rights reserved.
//

import Foundation
import Moya
import FindaUtils

public enum AssetManageAPI {
  case calendarRepaymentSchedule(month: String)
  case getCheckingAccount(cache: Bool)
  case getCheckingDetail(accountId: Int)
  case getDepositAndSavings(cache: Bool)
  case getDepositAndSavingsDetail(accountId: Int)
  case getPayday
  case postPayday(Int)
  case postTransactions(request: AssetTransactionRequest)
  case cashFlow
  case creditInterlockInfo
  case todayLimitCheckInfo
  case putChecking(accountId: Int, param: [String: Any])
  case putDepositAndSavings(accountId: Int, param: [String: Any])
  case consentSummary(isCache: Bool)
  
  case putConnectedAccount(orgCode: String, cardId: String, connectedAccountNum: String)
  
  /// Card
  case getCards(cache: Bool)
  case getBillDetail(orgCode: String, billDate: Date, cache: Bool)
  case getCardDetail(orgCode: String, cardId: String)
  case getCardInfo(orgCode: String, cardId: String)
  case putCard(orgCode: String, cardId: String, isVisible: Bool?, isInstallmentPayVisible: Bool?)
  case hideCard(orgCode: String, isVisible: Bool)
  case cardTransactions(startDate: String, endDate: String)
  case getCardList
}

extension AssetManageAPI: BaseAPI {
  public var method: Moya.Method {
    switch self {
    case .calendarRepaymentSchedule:
      return .get
    case .putCard:
      return .put
    case .getCheckingAccount:
      return .get
    case .getDepositAndSavings:
      return .get
    case .getCheckingDetail:
      return .get
    case .getDepositAndSavingsDetail:
      return .get
    case .getPayday:
      return .get
    case .postPayday:
      return .post
    case .postTransactions:
      return .post
    case .cashFlow:
      return .get
    case .creditInterlockInfo:
      return .get
    case .todayLimitCheckInfo:
      return .get
    case .putChecking:
      return .put
    case .putDepositAndSavings:
      return .put
    case .getCards:
      return .get
    case .cardTransactions:
      return .get
    case .hideCard:
      return .put
    case .consentSummary:
      return .get
    case .getBillDetail:
      return .get
    case .getCardDetail:
      return .get
    case .getCardInfo:
      return .get
    case .putConnectedAccount:
      return .put
    case .getCardList:
      return .get
    }
  }
  
  public var task: Task {
    switch self {
    case .calendarRepaymentSchedule(let month):
      return .requestParameters(
        parameters: ["search-month": month],
        encoding: URLEncoding.queryString
      )
    case .putCard(orgCode: let orgCode, cardId: let cardId, isVisible: let isVisible, isInstallmentPayVisible: let isInstallmentPayVisible):
      var param = [
        "orgCode": orgCode,
        "cardId": cardId
      ] as [String: Any]
      if let isVisible = isVisible {
        param["isVisible"] = isVisible
      }
      if let isInstallmentPayVisible = isInstallmentPayVisible {
        param["isInstallmentPayVisible"] = isInstallmentPayVisible
      }
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .getCheckingAccount(cache: let cache):
      let param = ["cache": cache ? "true" : "false"]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .getCheckingDetail:
      return .requestPlain
    case .getDepositAndSavings(cache: let cache):
      let param = ["cache": cache ? "true" : "false"]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .getDepositAndSavingsDetail:
      return .requestPlain
    case .getPayday:
      return .requestPlain
    case .postPayday(let payDay):
      return .requestParameters(
        parameters: ["payday": payDay],
        encoding: JSONEncoding.default
      )
    case .postTransactions(request: let body):
      if let data = try? JSONEncoder().encode(body),
         let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
        return .requestParameters(parameters: json,
                                  encoding: JSONEncoding.init(options: .fragmentsAllowed))
      } else {
        fatalError("occurs error to convert oject data to json.")
      }
    case .cashFlow:
      return .requestPlain
    case .creditInterlockInfo:
      return .requestPlain
    case .todayLimitCheckInfo:
      return .requestPlain
    case .putChecking(accountId: _, param: let param):
      return .requestParameters(parameters: param,
                                encoding: JSONEncoding.init(options: .fragmentsAllowed))
    case .putDepositAndSavings(accountId: _, param: let param):
      return .requestParameters(parameters: param,
                                encoding: JSONEncoding.init(options: .fragmentsAllowed))
    case .getCards(cache: let cache):
      let param = ["cache": cache ? "true" : "false"]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .cardTransactions(startDate: let startDate, endDate: let endDate):
      let params: [String: Any] = ["start-date": startDate, "end-date": endDate]
      let encoding = URLEncoding(destination: .queryString,
                                 arrayEncoding: .noBrackets,
                                 boolEncoding: .numeric)
      return .requestParameters(parameters: params,
                                encoding: encoding)
    case .hideCard(orgCode: let orgCode, isVisible: let isVisible):
      let body = [
        "orgCode": orgCode,
        "isVisible": isVisible
      ] as [String : Any]
      return .requestParameters(parameters: body,
                                encoding: JSONEncoding.init(options: .fragmentsAllowed))
    case .consentSummary(isCache: let isCache):
      let param = ["isCache": isCache ? "true" : "false"]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .getBillDetail(orgCode: _, billDate: let month, cache: let cache):
      let formattedDate = TimeUtil.formattedString(from: month, with: "yyyyMM")
      let param = [
        "search-month": formattedDate ?? "",
        "cache": cache ? "true" : "false"
      ] as [String: Any]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .getCardDetail(orgCode: _, cardId: _):
      let date = Date()
      let formattedDate = TimeUtil.formattedString(from: date, with: "yyyyMM")
      let param = [
        "search-month": formattedDate ?? ""
      ] as [String: Any]
      return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    case .getCardInfo:
      return .requestPlain
    case .putConnectedAccount(orgCode: _, cardId: _, connectedAccountNum: let num):
      let param = [
        "connectedAccountNum": num
      ] as [String: Any]
      return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    case .getCardList:
      return .requestPlain
    }
  }
  
  
  public var baseURL: URL {
    guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
    return url
  }
  
  
  public var path: String {
    switch self {
    case .calendarRepaymentSchedule:
      return "/ams/v1/calendars/repayment-schedule"
    case .putCard:
      return "/ams/v2/cms/cards"
    case .getCheckingAccount:
      return "/ams/v1/checking"
    case .getCheckingDetail(accountId: let id):
      return "/ams/v1/checking/\(id)"
    case .getDepositAndSavings:
      return "/ams/v1/deposit-and-savings"
    case .getDepositAndSavingsDetail(accountId: let id):
      return "/ams/v1/deposit-and-savings/\(id)"
    case .getPayday:
      return "/ams/v1/users/payday"
    case .postPayday:
      return "/ams/v1/users/payday"
    case .postTransactions:
      return "/mydata/dms/transaction"
    case .cashFlow:
      return "/ams/v1/cashflow"
    case .creditInterlockInfo:
      return "/ams/v1/lms/credit/interlock-info"
    case .todayLimitCheckInfo:
      return "/ams/v2/event/loan-challenge/today-limit-check"
    case .putChecking(accountId: let id, param: _):
      return "/ams/v1/checking/\(id)"
    case .putDepositAndSavings(accountId: let id, param: _):
      return "/ams/v1/deposit-and-savings/\(id)"
    case .getCards:
      return "/ams/v1/cms/cards/refresh"
    case .cardTransactions:
      return "/ams/v1/cms/cards/transactions"
    case .hideCard:
      return "/ams/v1/cms/cards"
    case .consentSummary:
      return "/mydata/consent/summary"
    case .getBillDetail(orgCode: let orgCode, billDate: _, cache: _):
      return "/ams/v2/cms/cards/bill-detail-info/\(orgCode)"
    case .getCardDetail(orgCode: let orgCode, cardId: let cardId):
      return "/ams/v2/cms/cards/detail-info/\(orgCode)/\(cardId)"
    case .getCardInfo(orgCode: let orgCode, cardId: let cardId):
      return "/ams/v1/cms/cards/\(orgCode)/\(cardId)"
    case .putConnectedAccount(orgCode: let orgCode, cardId: let cardId, connectedAccountNum: _):
      return "/ams/v2/cms/cards/\(orgCode)/\(cardId)/withdrawal-account-info"
    case .getCardList:
      return "/ams/v2/cms/cards"
    }
  }
}
