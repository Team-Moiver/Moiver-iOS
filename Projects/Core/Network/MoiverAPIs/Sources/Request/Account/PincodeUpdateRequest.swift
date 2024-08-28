//
//  PincodeUpdateRequest.swift
//  Finda
//
//  Created by mincheol on 2023/01/16.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation
public struct PincodeUpdateRequest: Codable {
    public var userId: Int
    public var encryptedPincode: String
    
    public init(userId: Int, encryptedPincode: String) {
        self.userId = userId
        self.encryptedPincode = encryptedPincode
    }
}

