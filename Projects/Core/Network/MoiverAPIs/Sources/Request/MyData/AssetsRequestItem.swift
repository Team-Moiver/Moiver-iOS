//
//  AssetsRequestItem.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/24.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation
import ObjectMapper

public struct AssetRequestItems: Mappable, Decodable {
  public var reqList: [ConsentReqList]
  public var isConsentTransMemo: String
  public var isConsentMerchantNameRegno: String
  public var assetCategory: String
  public var depositOrgList: [String]
  
  public init() {
    self.reqList = []
    self.isConsentTransMemo = "false"
    self.isConsentMerchantNameRegno = "false"
    self.assetCategory = ""
    self.depositOrgList = []
  }
  
  public init?(map: Map) {
    self.reqList = []
    self.isConsentTransMemo = "false"
    self.isConsentMerchantNameRegno = "false"
    self.assetCategory = ""
    self.depositOrgList = []
  }
  
  public mutating func mapping(map: Map) {
    self.reqList >>> map["consentReqList"]
    self.isConsentTransMemo >>> map["isConsentTransMemo"]
    self.isConsentMerchantNameRegno >>> map["isConsentMerchantNameRegno"]
    self.assetCategory >>> map["assetCategory"]
    self.depositOrgList >>> map["depositOrgList"]
  }
}

public struct TargetInfo: Mappable, Decodable {
  public var items: [AssetItems]
  
  public init() {
    self.items = []
  }
  
  public init?(map: Map) {
    
    self.items = []
  }
  
  public mutating func mapping(map: Map) {
    self.items >>> map["asset_list"]
  }
}

public struct ConsentReqList: Mappable, Decodable {
  public var orgCode: String
  public var isScheduled: String
  public var endDate: String
  public var isConsentTransMemo: String
  public var isConsentMerchantNameRegno: String
  public var scope: String
  public var targetInfo: [TargetInfo]
  
  
  public init() {
    self.orgCode = ""
    self.isScheduled = "false"
    self.endDate = ""
    self.isConsentTransMemo = "false"
    self.isConsentMerchantNameRegno = "false"
    self.scope = ""
    self.targetInfo = []
  }
  
  public init?(map: Map) {
    self.isScheduled = "false"
    self.endDate = ""
    self.targetInfo = []
    self.orgCode = ""
    self.isConsentTransMemo = "false"
    self.scope = ""
    self.isConsentMerchantNameRegno = "false"
  }
  
  public mutating func mapping(map: Map) {
    self.isScheduled >>> map["consentInfo.consent.is_scheduled"]
    self.endDate >>> map["consentInfo.consent.end_date"]
    self.scope >>> map["consentInfo.consent.scope"]
    self.targetInfo >>> map["consentInfo.consent.target_info"]
    self.orgCode >>> map["orgCode"]
  }
}

public struct AssetItems: Mappable, Decodable {
  public var asset: String
  public var seqno: String?
  public var assetName: String
  public var industry: String
  public var orgCode: String
  
  
  public init(asset: String, seqno: String?, assetName: String,
              industry: String, orgCode: String) {
    self.asset = asset
    self.seqno = seqno
    self.assetName = assetName
    self.industry = industry
    self.orgCode = orgCode
    
  }
  
  public init?(map: Map) {
    self.asset = ""
    self.seqno = nil
    self.assetName = ""
    self.industry = ""
    self.orgCode = ""
  }
  
  public mutating func mapping(map: Map) {
    self.asset >>> map["asset"]
    self.seqno >>> map["seqno"]
    self.assetName >>> map["assetName"]
    self.industry >>> map["industry"]
    self.orgCode >>> map["orgCode"]
  }
}
