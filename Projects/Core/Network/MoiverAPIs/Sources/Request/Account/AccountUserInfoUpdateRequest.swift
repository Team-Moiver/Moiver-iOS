//
//  AccountUserInfoUpdateRequest.swift
//  Finda
//
//  Created by donghyun on 2023/01/11.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct AccountUserInfoUpdateRequest: Encodable {
    public var userId: Int
    public var idToken: String
    
    public init(userId: Int, idToken: String) {
        self.userId = userId
        self.idToken = idToken
    }
}
