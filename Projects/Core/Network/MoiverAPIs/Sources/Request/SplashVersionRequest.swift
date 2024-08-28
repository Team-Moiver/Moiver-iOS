//
//  SplashVersionRequest.swift
//  FindaAPIs
//
//  Created by mincheol on 2023/07/18.
//  Copyright © 2023 Finda. All rights reserved.
//

import Foundation

public struct SplashVersionRequest {
    public var device: String
    
    public init(device: String) {
        self.device = device
    }
    
    public init() {
        self.device = ""
    }
}
