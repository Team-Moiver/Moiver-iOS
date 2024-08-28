//
//  ChannelIoMemberRequest.swift
//  Finda
//
//  Created by 엄기철 on 2021/11/07.
//  Copyright © 2021 Finda. All rights reserved.
//

import ObjectMapper

public struct ChannelIoMemberRequest: Mappable {
    
    public var memberId: String
    
    public init() {
        memberId = ""
    }
    
    public init?(map: Map) {
        memberId = ""
    }
    
    public mutating func mapping(map: Map) {
        memberId >>> map["input"]
    }
}
