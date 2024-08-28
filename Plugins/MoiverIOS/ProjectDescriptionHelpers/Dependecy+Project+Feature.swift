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
            public struct FeatureKit {}
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

