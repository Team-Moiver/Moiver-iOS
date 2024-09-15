//
//  Dependecy+Project+Core.swift
//  UtilityPlugin
//
//  Created by mincheol on 11/9/23.
//

import Foundation

public extension Dep.Project.Core.MoiverCoreKit {
    static let group = "MoiverCoreKit"
    static let MoiverCoreKit: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/Core/\(group)"))
}

public extension Dep.Project.Core.MoiverResorucePackage {
    static let group = "MoiverResourcePackage"
    static let MoiverResorucePackage: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/Core/\(group)"))
}

public extension Dep.Project.Core.MoiverThirdPartyLibManager {
    static let group = "MoiverThirdPartyLibManager"
    static let MoiverThirdPartyLibManager: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/Core/\(group)"))
}

public extension Dep.Project.Core.MoiverUtils {
    static let group = "MoiverUtils"
    static let MoiverUtils: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/Core/\(group)"))
}

public extension Dep.Project.Core.Network.MoiverAPIs {
    static let group = "Network"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Core/\(group)/\(name)")) }

    static let MoiverAPIs = project(name: "MoiverAPIs")
}

public extension Dep.Project.Core.Network.Networking {
    static let group = "Network"
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Core/\(group)/\(name)")) }

    static let Networking = project(name: "Networking")
}

public extension Dep.Project.Core.MoiverUI {
    static let group = "MoiverUI"
    static let MoiverUI: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/Core/\(group)"))
}
