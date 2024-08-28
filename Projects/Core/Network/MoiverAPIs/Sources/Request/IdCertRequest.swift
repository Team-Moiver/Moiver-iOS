//
//  IdCertParams.swift
//  Finda
//
//  Created by 박영진 on 2022/03/03.
//  Copyright © 2022 Finda. All rights reserved.
//

import ObjectMapper

public struct IdsTxRequest: Codable {
    public let cellNumber, name, rrnBirth, rrnGender: String
    public let telco: Int
    
    public init(cellNumber: String, name: String, rrnBirth: String, rrnGender: String, telco: Int) {
        self.cellNumber = cellNumber
        self.name = name
        self.rrnBirth = rrnBirth
        self.rrnGender = rrnGender
        self.telco = telco
    }
}

public struct IdsTxResultRequest: Codable {
    public let cellNumber, optNo, txSeqNo: String
    
    public init(cellNumber: String, optNo: String, txSeqNo: String) {
        self.cellNumber = cellNumber
        self.optNo = optNo
        self.txSeqNo = txSeqNo
    }
}

public struct KcbRealNameRequest: Codable {
    public let userName: String
    public let rrn: String
    
    public init(userName: String, rrn: String) {
        self.userName = userName
        self.rrn = rrn
    }
}
