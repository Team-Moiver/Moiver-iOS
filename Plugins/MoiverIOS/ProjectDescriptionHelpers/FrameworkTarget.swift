//
//  FrameworkTarget.swift
//  UtilityPlugin
//
//  Created by mincheol on 2023/05/31.
//

import Foundation

public enum FeatureTarget: Hashable {
    case staticLibrary
    case dynamicFramework
    case tests
    case testing
    case example

    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticLibrary: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicFramework }
}
