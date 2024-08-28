//
//  AccountUserAlarmRequest.swift
//  Finda
//
//  Created by donghyun on 2023/03/02.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct AccountUserAlarmParam {
    public let alarmUsedCategory: String
    
    public init(category: Category) {
        self.alarmUsedCategory = category.rawValue
    }
}

extension AccountUserAlarmParam {
    public enum Category: String {
        case MORE_HOME
        case CASH_FLOW
        case FINANCIAL_PRODUCT
    }
}
