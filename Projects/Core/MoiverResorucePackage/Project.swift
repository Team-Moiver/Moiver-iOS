//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/05/31.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "MoiverResorucePackage"
private let iOSTargetVersion = "17.2"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: []
)
