//
//  OverAgeRequest.swift
//  Finda
//
//  Created by 엄기철 on 2021/11/17.
//  Copyright © 2021 Finda. All rights reserved.
//

import Foundation
import ObjectMapper

public struct OverAgeRequest: Mappable {
    
    public var overage: Int
    public var rrnBirth: String
    public var rrnGender: String
    
    public init() {
        overage = 0
        rrnBirth = ""
        rrnGender = ""
    }
    
    public init?(map: Map) {
        overage = 0
        rrnBirth = ""
        rrnGender = ""
    }
    
    public mutating func  mapping(map: Map) {
        overage >>> map["overage"]
        rrnBirth >>> map["rrnBirth"]
        rrnGender >>> map["rrnGender"]
    }
}

