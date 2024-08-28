//
//  Project+Framework+Templates+Helper.swift
//  UtilityPlugin
//
//  Created by mincheol on 8/28/24.
//

import Foundation
import ProjectDescription

public struct XCConfig {
    private struct Path {
        static func featureConfig(_ name: String) -> ProjectDescription.Path {
            return .relativeToRoot("Configurations/Features/\(name).xcconfig")
        }
        static func frameworkConfig(_ name: String) -> ProjectDescription.Path {
            return .relativeToRoot("Configurations/Frameworks/\(name).xcconfig")
        }
    }
    
    public static let feature: [Configuration] = [
        .debug(name: "Product-Debug", xcconfig: Path.featureConfig("Product-Debug")),
        .release(name: "Product-Release", xcconfig: Path.featureConfig("Product-Release"))
        ]
    
    public static let framework: [Configuration] = [
        .debug(name: "Product-Debug", xcconfig: Path.frameworkConfig("Product-Debug")),
        .release(name: "Product-Release", xcconfig: Path.frameworkConfig("Product-Release"))
    ]
}
