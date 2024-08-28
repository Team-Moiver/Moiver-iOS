//
//  TermsEnrollmentDTO.swift
//  Finda
//
//  Created by myunggi on 2021/05/21.
//  Copyright © 2021 Finda. All rights reserved.
//

import ObjectMapper

public struct TermsEnrollmentRequest {
    public var agreements: [Agreement]
    
    public init(agreements: [Agreement]) {
        self.agreements = agreements
    }
}

extension TermsEnrollmentRequest {
    
    public struct Agreement: Codable {
        var agree: Bool
        var termsId: Int
        
        public init(agree: Bool, termsId: Int) {
            self.agree = agree
            self.termsId = termsId
        }
    }
}
