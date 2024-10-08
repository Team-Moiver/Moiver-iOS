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
private let iOSTargetVersion = "17.0"

let project = Project.framework(
    name: projectName,
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [
        .Project.Feature.FeatureKit.Home.Interface,
        .Project.Feature.FeatureKit.Home.Implementation,
        .Project.Feature.FeatureKit.Main.Interface,
        .Project.Feature.FeatureKit.Main.Implementation
    ]
)
