//
//  MoiverTargets+Moiver.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 8/28/24.
//
import Foundation

import ProjectDescription

extension Target.MoiverTargets {
    func makeMoiverTarget(
        _ name: String,
        _ platform: Platform,
        _ iOSTargetVersion: String,
        _ dependencies: [TargetDependency] = []
    ) -> Target {
        return Target (
            name: name,
            platform: platform,
            product: .app,
            productName: name,
            bundleId: "${PRODUCT_BUNDLE_IDENTIFIER}",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist:
                    .file(path: .relativeToManifest("Info.plist")),
            sources: [
                "Sources/**"
            ],
            resources: [
                "Resources/**"
            ],
            scripts: .init(),
            dependencies: dependencies,
            settings: MoiverCore.Constants.settingsTargetMoiver,
            additionalFiles: [.glob(pattern: .relativeToManifest("AppSuit/stscore.h"))]
        )
    }
}
