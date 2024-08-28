//
//  AssetTransactionRequest.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/11.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct AssetTransactionRequest: Codable {
    public var orgCode: String
    public var accountNumber: String
    public var seqNo: String
    public var fromDate: String
    public var toDate: String
    
    public init(orgCode: String, accountNumber: String, seqNo: String, fromDate: String, toDate: String) {
        self.orgCode = orgCode
        self.accountNumber = accountNumber
        self.seqNo = seqNo
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
