//
//  Proejct.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2024/08/28.
//
import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "FeatureKit"
private let iOSTargetVersion = "17.2"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: []
)
