//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/05/09.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "MoiverThirdPartyLibManager"
private let iOSTargetVersion = "17.2"

let dependencies: [Dep] =
Dep.SwiftPM.allCases.map { $0.packageSource }

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    packages: Package.Dependencies.allCases.map { $0.packageSource },
    dependencies: dependencies
)
