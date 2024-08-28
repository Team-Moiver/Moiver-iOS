//
//  OverAgeRegistRequest.swift
//  Finda
//
//  Created by donghyun on 2023/07/12.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct OverAgeRegistRequest: Encodable {
    public var rrnBirth: String
    public var rrnGender: String
    
    public init(rrnBirth: String, rrnGender: String) {
        self.rrnBirth = rrnBirth
        self.rrnGender = rrnGender
    }
}

