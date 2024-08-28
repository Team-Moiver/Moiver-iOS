//
//  UpdateAnalyticsDTO.swift
//  Finda
//
//  Created by mincheol on 2023/01/16.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct UpdateAnalyticsDTO: Codable {
    public var appInstanceId: String
    
    public init(appInstanceId: String) {
        self.appInstanceId = appInstanceId
    }
}
