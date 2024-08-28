//
//  MyDataAPI.swift
//  Finda
//
//  Created by jinseon on 2022/01/26.
//  Copyright © 2022 Finda. All rights reserved.
//

import Alamofire
import Moya
import ObjectMapper
import ObjectiveC

public enum MyDataAPI {
  case terms(requestType: MyDataTermsRequestType, page: Int, params: MyDataTermsParams)
  case termScope(asset: ConsentScopeParams)
  case register
  case orgs(isConsent: Bool) // 연동금융사 조회
  case repaymentOrgs // 상환계좌 연동금융사 조회
  case consentInfo
  case consentOrgs
  case deleteConsent
  case consentAsestsInfo(orgCode: String, includeAllIndustry: Bool)
  case deleteConsentOrg(orgCode: String)
  case signData(MyDataSignDataParams)
  case signRequest(MyDataCASignRequestParams)
  case signAssetRequest(MyDataAssetCASignRequestParams)
  case depositORGCode(MyDataDepositORGCode)
  case authOrg(MyDataAuthOrgParams)
  case authCa(MyDataAuthCaParams)
  case assetAuthCa(MyDataAssetAuthCaParams)
  case authIndiv(MyDataAuthIndivParams)
  case authIndivToken(MyDataAuthIndivTokenParams)
  case progress(MyDataProgressParams)
  case assets(authSession: String, processType: String, depositOrgList: [String])
  case progressUCPID(MyDataProgressParams)
  case progressContent(MyDataProgressParams)
  case assetSignData(params: AssetRequestItems, authSession: String)
  case orgAssets(orgCode: String)
  case savedAssets
  case consentExpired
  case extendSignData(parameter: MyDataExtendSignDataParams)
  case orgList(isConsent: Bool)
}

extension MyDataAPI: BaseAPI {
    public var method: Moya.Method {
    switch self {
    case .termScope:
      return .post
    case .terms:
      return .get
    case .register:
      return .post
    case .orgs, .repaymentOrgs, .orgList:
      return .get
    case .consentInfo:
      return .get
    case .consentOrgs:
      return .get
    case .deleteConsent, .deleteConsentOrg:
      return .delete
    case .consentAsestsInfo:
      return .get
    case .signData, .signRequest, .signAssetRequest, .authOrg, .authCa, .assetAuthCa, .authIndiv, .authIndivToken, .extendSignData:
      return .post
    case .progress:
      return .get
    case .assets:
      return .get
    case .progressUCPID, .progressContent:
      return .get
    case .assetSignData:
      return .post
    case .depositORGCode:
      return .get
    case .orgAssets:
      return .get
    case .savedAssets:
      return .get
    case .consentExpired:
      return .get
    }
  }
  
    public var task: Task {
    switch self {
    case .termScope(let params):
      return .requestJSONEncodable(params.body)
    case .terms(requestType: _, page: _, params: let params):
      var newParams: [String: Any] = [:]
      if let isScheduled = params.isScheduled {
        newParams.updateValue(isScheduled, forKey: "scheduled")
      }
      if let endDate = params.endDate {
        newParams.updateValue(endDate, forKey: "endDate")
      }
      newParams.updateValue(params.orgList.joined(separator: ","), forKey: "orgList")
      let encoding = URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      return .requestParameters(parameters: newParams, encoding: encoding)
    case .consentAsestsInfo, .deleteConsentOrg, .orgAssets:
      return .requestParameters(
        parameters: ["includeAllIndustry": "\(false)"],
        encoding: URLEncoding.default
      )
    case .register, .repaymentOrgs, .consentInfo, .consentOrgs, .deleteConsent:
      return .requestPlain
    case .assets(authSession: _, processType: let type, depositOrgList: let list):
      let encoding = URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      let params: [String: Any] = ["assetCategory": type, "depositOrgList": list.joined(separator: ",")]
      return .requestParameters(parameters: params, encoding: encoding)
    case .signData(let params):
      return .requestJSONEncodable(params)
    case .signRequest(let params):
      return .requestJSONEncodable(params.body)
    case .signAssetRequest(let params):
      return .requestJSONEncodable(params.body)
    case .authOrg(let params):
      return .requestJSONEncodable(params.body)
    case .authCa(let params):
      return .requestJSONEncodable(params.body)
    case .assetAuthCa(let params):
      return .requestJSONEncodable(params.body)
    case .authIndiv(let params):
      return .requestJSONEncodable(params.body)
    case .authIndivToken(let params):
      return .requestJSONEncodable(params.body)
    case .progress:
      return .requestPlain
    case .progressUCPID, .progressContent:
      return .requestPlain
    case let .assetSignData(params, _):
      return .requestParameters(parameters: params.toJSON(), encoding: JSONEncoding.default)
    case .depositORGCode(let params):
      let joined = params.orgList.joined(separator: ",")
      let newParam = ["orgList": joined]
      return .requestParameters(parameters: newParam, encoding: URLEncoding.queryString)
    case .orgs(isConsent: let isConsent), .orgList(let isConsent):
      return .requestParameters(parameters: ["isConsent": "\(isConsent)"], encoding: URLEncoding.queryString)
    case .savedAssets:
      return .requestPlain
    case .consentExpired:
      return .requestPlain
    case .extendSignData(let parameters):
      return .requestJSONEncodable(parameters)
    }
  }
  
    public var baseURL: URL {
    guard let url = URL(string: greenURL()) else { fatalError("Bad Request baseURL")}
    return url
  }
  
    public var path: String {
    switch self {
    case .termScope:
      return "/mydata/v2/terms/scope"
    case .terms(requestType: let type, page: let page, params: _):
      return "/mydata/v1/terms/\(type.rawValue)/\(page)"
    case .register:
      return "/mydata/auth/user"
    case .orgs:
      return "/mydata/v2/orgs"
    case .orgList:
      return "mydata/v2/org-list"
    case .repaymentOrgs:
      return "/mydata/v2/deposit/orgs"
    case .signData:
      return "/mydata/auth/org/sign-data"
    case .signRequest(let params):
      return "/mydata/auth/ca/sign_request/\(params.authSession)"
    case .signAssetRequest(let params):
      return "/mydata/auth/ca/sign_request/\(params.authSession)"
    case .authOrg(let params):
      return "/mydata/auth/orgs/\(params.authSeq)/\(params.authSession)"
    case .authCa(let params):
      return "/mydata/auth/ca/integ-auth/\(params.authSeq.rawValue)/\(params.authSession)"
    case .assetAuthCa(let params):
      return "/mydata/auth/ca/integ-auth/\(params.authSeq.rawValue)/\(params.authSession)"
    case .authIndiv:
      return "/mydata/auth/indiv/authorize"
    case .authIndivToken:
      return "/mydata/auth/indiv/token"
    case .progress(let params):
      return "/mydata/auth/org/progress/\(params.progressId)"
    case .consentInfo:
      return "/mydata/lms/consent-info"
    case .consentOrgs:
      return "/mydata/consent/orgs"
    case .deleteConsent:
      return "/mydata/consent"
    case .consentAsestsInfo(let code, _):
      return "/mydata/assets/consent-info/\(code)"
    case .deleteConsentOrg(orgCode: let code):
      return "mydata/consent/\(code)"
    case let .assets(authSession, _, _):
      return "mydata/assets/\(authSession)"
    case .progressUCPID(let params):
      return "/mydata/auth/org/progress/\(params.progressId)"
    case .progressContent(let params):
      return "/mydata/auth/org/consent/progress/\(params.progressId)"
    case let .assetSignData(_, authSession):
      return "/mydata/auth/asset/sign-data/\(authSession)"
    case .depositORGCode:
      return "/mydata/v1/deposit-org-code"
    case .orgAssets(orgCode: let orgCode):
      return "/mydata/assets/org-code/\(orgCode)"
    case .savedAssets:
      return "/mydata/assets/saved-org"
    case .consentExpired:
      return "/mydata/consent/expired"
    case .extendSignData:
      return "/mydata/auth/asset/extend/sign-data"
    }
  }
}
