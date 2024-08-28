//
//  Dependency+SwiftPM.swift
//  UtilityPlugin
//
//  Created by mincheol on 2024/08/28.
//

import Foundation
import ProjectDescription

extension Dep {
    public enum SwiftPM: String, CaseIterable{
        case KakaoSDKCommon
        case KakaoSDKShare
        case FirebaseAnalytics
        case FirebaseCrashlytics
        case FirebaseMessaging
        case FirebaseAnalyticsOnDeviceConversion
        case Swinject
    }
}

// MARK: - Swift Package

extension Dep.SwiftPM {
    public var packageSource: Dep {
        switch self {
        default: return .package(product: "\(self.rawValue)")
        }
    }
}

public extension Package {
    enum Dependencies: String, CaseIterable {
        case KakaoSDK
        case Swinject
    }
}

extension Package.Dependencies {
    static var github: String { "https://github.com" }
    public var packageSource: Package {
        switch self {
        case .KakaoSDK: return .remote(url: "\(Self.github)/kakao/kakao-ios-sdk", requirement: .branch("master"))
        case .Swinject: return .remote(url: "\(Self.github)/Swinject/Swinject.git", requirement: .branch("master"))
        }
    }
}
