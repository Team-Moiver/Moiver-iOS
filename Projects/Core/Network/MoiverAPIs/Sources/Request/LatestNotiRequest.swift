//
//  LatestNotiParams.swift
//  Finda
//
//  Created by donghyun on 2022/08/02.
//  Copyright © 2022 Finda. All rights reserved.
//

import Foundation

public struct LatestNotiRequest {
    public typealias Parameters = [String: Any]
    public var page: Int = 0
    public var size: Int = 1
    
    public init() {}
}

extension LatestNotiRequest {
    public func toParameters() -> Parameters {
        return [
            "page": page,
            "size": size
        ]
    }
}
