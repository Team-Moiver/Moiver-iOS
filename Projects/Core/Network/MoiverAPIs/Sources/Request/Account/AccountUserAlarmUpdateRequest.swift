//
//  AccountUserAlarmUpdateRequest.swift
//  Finda
//
//  Created by donghyun on 2023/03/02.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct AccountUserAlarmUpdateRequest: Encodable {
    public let alarmType: String
    public let value: Bool
    
    public init(alarmType: String, value: Bool) {
        self.alarmType = alarmType
        self.value = value
    }
}
