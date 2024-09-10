//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "DIContainer"
private let iOSTargetVersion = "17.0"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [
      .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager
    ]
)

