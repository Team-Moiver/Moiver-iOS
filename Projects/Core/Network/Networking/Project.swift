//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/07/11.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "Networking"
private let iOSTargetVersion = "17.2"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.staticLibrary],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [
        .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
        .Project.Core.MoiverUtils.MoiverUtils,
        .Project.Core.Network.MoiverAPIs.MoiverAPIs
    ]
)