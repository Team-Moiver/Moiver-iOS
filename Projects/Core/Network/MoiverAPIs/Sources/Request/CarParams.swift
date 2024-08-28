//
//  CarParams.swift
//  Finda
//
//  Created by 박영진 on 2021/09/23.
//  Copyright © 2021 Finda. All rights reserved.
//

import Foundation

public struct CarParams {
    public var carNum: String
    
    public var map: [String: String] {
        return ["carNum": self.carNum]
    }
    
    public init(carNum: String) {
        self.carNum = carNum
    }
}
