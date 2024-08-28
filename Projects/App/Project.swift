//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/07/11.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "Moiver"
private let iOSTargetVersion = "17.2"

let infoPlistPath: String = "Resources/SupportFiles/Info.plist"

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          settings: .settings(configurations: MoiverCore.configurations),
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .Project.Feature.FeatureKit.FeatureKit,
                            .Project.Core.MoiverCoreKit.MoiverCoreKit,
                            .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                            .Project.DIContainer.DIContainer
                          ]
)
