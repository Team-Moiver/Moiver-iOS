//
//  AutoLoanParams.swift
//  Finda
//
//  Created by 박영진 on 2022/03/14.
//  Copyright © 2022 Finda. All rights reserved.
//

import ObjectMapper

public struct AutoLoanApplicationRequest: Encodable {
    public var annualSalary: Int
    public var applicationTerms: [ApplicationTerm]
    //  var autoModelCode: String
    public var autoNo: String
    public var autoReleaseDate: String
    public var idToken: String
    public var loanAutoType: String
    public var loanCategoryType: String
    //  var productCategoryType: String
    public var rrn: String
    
    public init(annualSalary: Int, applicationTerms: [ApplicationTerm], autoNo: String, autoReleaseDate: String, idToken: String, loanAutoType: String, loanCategoryType: String, rrn: String) {
        self.annualSalary = annualSalary
        self.applicationTerms = applicationTerms
        self.autoNo = autoNo
        self.autoReleaseDate = autoReleaseDate
        self.idToken = idToken
        self.loanAutoType = loanAutoType
        self.loanCategoryType = loanCategoryType
        self.rrn = rrn
    }
    
    public struct ApplicationTerm: Encodable {
        public var termsId: Int
        public var termsYn: Bool
        public var purpose: String
      
        public enum CodingKeys: String, CodingKey {
          case termsId
          case termsYn
        }
        
        public init(id: Int, yn: Bool, purpose: String) {
            self.termsId = id
            self.termsYn = yn
            self.purpose = purpose
        }
    }
}

public struct AutoLoanReleaseNotificationRequest: Codable {
    public var applicationId: Int
    public var loanapplyId: Int
    
    public init(applicationId: Int, loanapplyId: Int) {
        self.applicationId = applicationId
        self.loanapplyId = loanapplyId
    }
}
