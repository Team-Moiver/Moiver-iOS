//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2024/09/15.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "MoiverUI"
private let iOSTargetVersion = "17.0"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.staticLibrary],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [
        .Project.Core.MoiverResorucePackage.MoiverResorucePackage
    ]
)
