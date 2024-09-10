//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/06/28.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "MoiverUtils"
private let iOSTargetVersion = "17.0"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.staticLibrary],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [
        .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
        .Project.Core.MoiverResorucePackage.MoiverResorucePackage
    ]
)
