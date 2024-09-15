//
//  Dependecy+Project.swift
//  UtilityPlugin
//
//  Created by mincheol on 11/9/23.
//

import Foundation

// MARK: Project
extension Dep {
    public struct Project {
        public struct Feature {
            public struct FeatureKit {
                public struct Home {}
                public struct Main {}
                public struct Community {}
            }
        }
        
        public struct FeatureCore {}
        
        public struct Core {
            public struct MoiverCoreKit {}
            public struct MoiverResorucePackage {}
            public struct MoiverThirdPartyLibManager {}
            public struct MoiverUI {}
            public struct MoiverUtils {}
            public struct Network {
                public struct MoiverAPIs {}
                public struct Networking {}
            }
        }
        public struct DIContainer {}
    }
}


// MARK: Feature
public extension Dep.Project.Feature.FeatureKit {
    static let group = "FeatureKit"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Features/\(group)")) }
    
    static let FeatureKit = project(name: "FeatureKit")
}

public extension Dep.Project.Feature.FeatureKit.Home {
    static let group = "Home"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Features/\(group)")) }
    
    static let Interface        = project(name: "\(group)Interface")
    static let Implementation    = project(name: "\(group)Implementation")
}

public extension Dep.Project.Feature.FeatureKit.Main {
    static let group = "Main"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Features/\(group)")) }
    
    static let Interface        = project(name: "\(group)Interface")
    static let Implementation    = project(name: "\(group)Implementation")
}

public extension Dep.Project.Feature.FeatureKit.Community {
    static let group = "Community"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Features/\(group)")) }
    
    static let Interface        = project(name: "\(group)Interface")
    static let Implementation    = project(name: "\(group)Implementation")
}
