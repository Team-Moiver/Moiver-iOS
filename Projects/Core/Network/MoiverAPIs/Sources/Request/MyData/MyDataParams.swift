//
//  MyDataParams.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/24.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import FindaUtils

public enum MyDataTermsRequestType: Int {
  case integrated1 = 0
  case integrated2 = 1
  case individual = 2
  case update = 3
  case skipStep = 4
  case expend = 5
}

public struct MyDataTermsParams {
  public let isScheduled: Bool?
  public let endDate: Int?
  public let orgList: [String]
  
  public init(isScheduled: Bool?, endDate: Int?, orgList: [String]) {
    self.isScheduled = isScheduled
    self.endDate = endDate
    self.orgList = orgList
  }
}

public struct ConsentScopeParams: Codable {
  public let body: Body
  
  public struct Body: Codable {
    let isCardLoan: Bool
    let isCardBill: Bool
    let isCardPoint: Bool
    let assetList: [OrgAsset]
    
    public init(isCardLoan: Bool, isCardBill: Bool, isCardPoint: Bool, assetList: [OrgAsset]) {
      self.isCardLoan = isCardLoan
      self.isCardBill = isCardBill
      self.isCardPoint = isCardPoint
      self.assetList = assetList
    }
  }
  
  public init(body: Body) {
    self.body = body
  }
}

public struct OrgAsset: Codable, Hashable {
  public var orgCode: String     // 마이데이터 기관코드
  public var asset: String        // 계좌번호 또는 카드ID, 토큰발행에 필수적인 정보
  public var seqno: String?        // 회차번호, 토큰발행에 필수적인 정보
  public var assetName: String   // 상품명
  public var isDeposit: Bool  // 예금계좌여부, 마이너스통장일 경우에도 true
  public var isSaving: Bool  // 예적금계좌여부
  public var isMinus: Bool    // 마이너스통장여부
  public var isConsent: Bool  // 전송요구여부
  /// 계좌 이상 여부
  public var isExceptional: Bool
  public var cardNumber: String?   // 카드번호
  /// 카드 타입
  /// 101 본인 - 신용카드
  /// 102 본인 - 체크카드
  /// 103 본인 - 소액신용체크
  /// 201 가족 - 신용카드
  public var accountType: AccountType?
  public var industry: OrgIndustryType
  
  public enum AccountType: String, Codable {
    case personalCreditCard
    case personalDebitCard
    case personalMicroCard
    case fersonalCreditCard
    case unknown
    
    public var title: String {
      switch self {
      case .personalCreditCard: return "신용"
      case .personalDebitCard: return "체크"
      case .personalMicroCard: return "소액신용"
      case .fersonalCreditCard: return "가족"
      case .unknown: return "카드번호"
      }
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if let value = try? container.decode(String.self) {
        switch value {
        case "101": self = .personalCreditCard
        case "102": self = .personalDebitCard
        case "103": self = .personalMicroCard
        case "201": self = .fersonalCreditCard
        default: self = .unknown
        }
      } else {
        self = .unknown
      }
    }
  }
  
  public init(orgCode: String, asset: String, seqno: String? = nil, assetName: String, isDeposit: Bool, isSaving: Bool, isMinus: Bool, isConsent: Bool, isExceptional: Bool, cardNumber: String? = nil, accountType: AccountType? = nil, industry: OrgIndustryType) {
    self.orgCode = orgCode
    self.asset = asset
    self.seqno = seqno
    self.assetName = assetName
    self.isDeposit = isDeposit
    self.isSaving = isSaving
    self.isMinus = isMinus
    self.isConsent = isConsent
    self.isExceptional = isExceptional
    self.cardNumber = cardNumber
    self.accountType = accountType
    self.industry = industry
  }
}

@frozen public enum OrgIndustryType: String, Codable, CaseIterable {
  case bank
  case savings
  case card
  case capital
  case insu
  
  public var title: String {
    switch self {
    case .bank: return "은행·저축은행"
    case .savings: return "저축은행"
    case .card: return "카드"
    case .capital: return "캐피탈"
    case .insu: return "보험"
    }
  }
}

public struct MyDataCASignRequestParams {
  
  public let authSession: String
  
  public let body: Body
  
  public struct Body: Codable {
    public let caOrg: String
    public let list: JSON
    public let returnAppSchemeUrl: String
    public let realName: String
    public let phoneNum: String
    
    public init(
      caOrg: String,
      list: JSON,
      returnAppSchemeUrl: String,
      realName: String = UserDefaultManager.shared.userName ?? "",
      phoneNumber: String = UserDefaultManager.shared.cellNumber ?? ""
    ) {
      self.caOrg = caOrg
      self.list = list
      self.returnAppSchemeUrl = returnAppSchemeUrl
      self.realName = realName
      self.phoneNum = "+82\(phoneNumber.dropFirst())"
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: MyDataCASignRequestParams.Body.CodingKeys.self)
      try container.encode(self.caOrg, forKey: .caOrg)
      try container.encode(self.list, forKey: .list)
      if !returnAppSchemeUrl.isEmpty {
        try container.encode(self.returnAppSchemeUrl, forKey: .returnAppSchemeUrl)
      }
      try container.encode(self.realName, forKey: .realName)
      try container.encode(self.phoneNum, forKey: .phoneNum)
    }
  }
  
  public init(authSession: String, body: Body) {
    self.authSession = authSession
    self.body = body
  }
}

public struct MyDataAssetCASignRequestParams {
  
  public let authSession: String
  
  public let body: Body
  
  public struct Body: Codable {
    public let caOrg: String
    public let list: JSON
    public let returnAppSchemeUrl: String
    public let realName: String
    public let phoneNum: String
    
    public init(
      caOrg: String,
      list: JSON,
      returnAppSchemeUrl: String,
      realName: String = UserDefaultManager.shared.userName ?? "",
      phoneNumber: String = UserDefaultManager.shared.cellNumber ?? ""
    ) {
      self.caOrg = caOrg
      self.list = list
      self.returnAppSchemeUrl = returnAppSchemeUrl
      self.realName = realName
      self.phoneNum = "+82\(phoneNumber.dropFirst())"
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: MyDataAssetCASignRequestParams.Body.CodingKeys.self)
      try container.encode(self.caOrg, forKey: .caOrg)
      try container.encode(self.list, forKey: .list)
      if !returnAppSchemeUrl.isEmpty {
        try container.encode(self.returnAppSchemeUrl, forKey: .returnAppSchemeUrl)
      }
      try container.encode(self.realName, forKey: .realName)
      try container.encode(self.phoneNum, forKey: .phoneNum)
    }
  }
  
  public init(authSession: String, body: Body) {
    self.authSession = authSession
    self.body = body
  }
}

public struct MyDataDepositORGCode: Codable {
  public let orgList: [String]
  
  enum CodingKeys: String, CodingKey {
    case orgList = "org_list"
  }
  
  public init(orgList: [String]) {
    self.orgList = orgList
  }
}


public struct MyDataAuthOrgParams {
  
  public let authSeq: AuthSeq
  
  public let authSession: String
  
  public let body: JSON
  
  public enum AuthSeq: String {
    case ucpid
    case contents
  }
  public init(authSeq: AuthSeq, authSession: String, body: JSON) {
    self.authSeq = authSeq
    self.authSession = authSession
    self.body = body
  }
}

public struct MyDataAuthCaParams {
  
  public let authSeq: AuthSeq
  
  public let authSession: String
  
  public let body: Body
  
  public enum AuthSeq: String {
    case ucpid
    case contents
  }
  
  public struct Body: Codable {
    public let caOrg: String
    public let list: JSON
    public let returnAppSchemeUrl: String
    
    public init(caOrg: String, list: JSON, returnAppSchemeUrl: String) {
      self.caOrg = caOrg
      self.list = list
      self.returnAppSchemeUrl = returnAppSchemeUrl
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: MyDataAuthCaParams.Body.CodingKeys.self)
      try container.encode(self.caOrg, forKey: .caOrg)
      try container.encode(self.list, forKey: .list)
      if !returnAppSchemeUrl.isEmpty {
        try container.encode(self.returnAppSchemeUrl, forKey: .returnAppSchemeUrl)
      }
    }
  }
  
  public init(authSeq: AuthSeq, authSession: String, body: Body) {
    self.authSeq = authSeq
    self.authSession = authSession
    self.body = body
  }
}

public struct MyDataAssetAuthCaParams {
  
  public let authSeq: AuthSeq
  
  public let authSession: String
  
  public let body: Body
  
  public enum AuthSeq: String {
    case ucpid
    case contents
  }
  
  public struct Body: Codable {
    public let caOrg: String
    public let list: JSON
    public let returnAppSchemeUrl: String
    
    public init(caOrg: String, list: JSON, returnAppSchemeUrl: String) {
      self.caOrg = caOrg
      self.list = list
      self.returnAppSchemeUrl = returnAppSchemeUrl
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: MyDataAssetAuthCaParams.Body.CodingKeys.self)
      try container.encode(self.caOrg, forKey: .caOrg)
      try container.encode(self.list, forKey: .list)
      if !returnAppSchemeUrl.isEmpty {
        try container.encode(self.returnAppSchemeUrl, forKey: .returnAppSchemeUrl)
      }
    }
  }
  
  public init(authSeq: AuthSeq, authSession: String, body: Body) {
    self.authSeq = authSeq
    self.authSession = authSession
    self.body = body
  }
}

public struct MyDataAuthIndivParams {
  public let body: Body
  
  public struct Body: Codable {
    public let appScheme: String
    public let orgCode: String
    
    public init(appScheme: String, orgCode: String) {
      self.appScheme = appScheme
      self.orgCode = orgCode
    }
  }
  
  public init(body: Body) {
    self.body = body
  }
}

public struct MyDataAuthIndivTokenParams {
  
  public let body: Body
  
  public struct Body: Codable {
    public let code: String
    public let state: String
    public let apiTranId: String
    
    public enum CodingKeys: String, CodingKey {
      case code
      case state
      case apiTranId = "api_tran_id"
    }
    
    public init(code: String, state: String, apiTranId: String) {
      self.code = code
      self.state = state
      self.apiTranId = apiTranId
    }
  }
  
  public init(body: Body) {
    self.body = body
  }
}

public struct MyDataProgressParams {
  public let progressId: Int
  
  public init(progressId: Int) {
    self.progressId = progressId
  }
}

public struct MyDataExtendSignDataParams: Codable {
  /// 만료일자
  public let endDate: String
  /// 정기적 전송 동의 여부
  public let isScheduled: Bool
  
  public init(endDate: String, isScheduled: Bool) {
    self.endDate = endDate
    self.isScheduled = isScheduled
  }
}

public struct MyDataSignDataParams: Codable {
  public let orgList: [String]
  public let depositOrgList: [String]
  public let includeAllIndustry: Bool
  
  public enum CodingKeys: String, CodingKey {
    case orgList = "org_list"
    case depositOrgList = "deposit_org_list"
    case includeAllIndustry = "includeAllIndustry"
  }
  
  public init(orgList: [String], depositOrgList: [String], includeAllIndustry: Bool) {
    self.orgList = orgList
    self.depositOrgList = depositOrgList
    self.includeAllIndustry = includeAllIndustry
  }
}
