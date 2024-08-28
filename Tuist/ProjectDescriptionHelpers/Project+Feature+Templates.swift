//
//  Project+Feature+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2024/08/28.
//

import ProjectDescription
import UtilityPlugin

extension Project { 
    public static let organizationName = "Moiver"
    public static func feature(
        name: String,
        platform: Platform,
        targets: Set<FeatureTarget> = Set([.staticLibrary]),
        iOSTargetVersion: String,
        packages: [Package] = [],
        interfaceDependencies: [TargetDependency] = [],
        dependencies: [TargetDependency] = [],
        exampleDependencies: [TargetDependency] = []
    ) -> Project {
        var settings: SettingsDictionary
        var projectTargets: [Target] = []
        let sources: SourceFilesList = ["Interface/Sources/**"]
        let resources: ResourceFileElements
        let interfaceProduct: Product = .framework
        
        settings = [
            "OTHER_LDFLAGS" : "$(inherited)",
            "ONLY_ACTIVE_ARCH": "NO"
        ]
        resources = ["Interface/Resources/**"]
        
        if targets.contains(where: { $0.hasFramework }) {
            let interface = Target(
                name: "\(name)Interface",
                platform: platform,
                product: interfaceProduct,
                bundleId: "kr.co.Moiver.interface.\(name)Interface",
                deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                infoPlist: .default,
                sources: sources,
                resources: resources,
                dependencies: [
                    .Project.Core.MoiverCoreKit.MoiverCoreKit,
                    .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                    .Project.DIContainer.DIContainer
                ] + interfaceDependencies,
                settings: .settings(base: settings,configurations: XCConfig.feature)
            )
            
            let implementation = Target(
                name: "\(name)Implementation",
                platform: platform,
                product: .framework,
                bundleId: "kr.co.Moiver.implementation.\(name)Implementation",
                deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                infoPlist: .default,
                sources: ["Implementation/Sources/**"],
                resources: ["Implementation/Resources/**"],
                dependencies: [
                    .target(name: "\(name)Interface"),
                    .Project.Core.MoiverCoreKit.MoiverCoreKit,
                    .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                    .Project.DIContainer.DIContainer
                ] + dependencies,
                settings: .settings(base: settings, configurations: XCConfig.feature)
            )
            
            
            projectTargets.append(interface)
            projectTargets.append(implementation)
        }
        
      if targets.contains(.tests) {
        let testTarget = Target(
          name: "\(name)Tests",
          platform: platform,
          product: .unitTests,
          bundleId: "kr.co.Moiver.Tests.\(name)Tests",
          deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
          infoPlist: .default,
          sources: ["\(name)Tests/**"],
          resources: ["\(name)Tests/TestDoubles/**"],
          dependencies: [
            .target(name: "\(name)Interface"),
            .target(name: "\(name)Implementation"),
            .package(product: "RxTest"),
            .Project.Core.MoiverCoreKit.MoiverCoreKit,
            .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
            .Project.DIContainer.DIContainer
          ] + interfaceDependencies + dependencies,
          settings: .settings(base: settings, configurations: XCConfig.feature)
        )
        projectTargets.append(testTarget)
      }
      
        if targets.contains(.example) {
            let example = Target(
                name: "\(name)Example",
                platform: platform,
                product: .app,
                bundleId: "kr.co.Moiver.example.\(name)",
                deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                infoPlist: .extendingDefault(with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "LSSupportsOpeningDocumentsInPlace": true,
                    "UIFileSharingEnabled": true,
                ]),
                sources: ["Example/Sources/**"],
                resources: ["Example/Resources/**"],
                dependencies: [
                    .target(name: "\(name)Interface"),
                    .target(name: "\(name)Implementation"),
                    .Project.Core.MoiverCoreKit.MoiverCoreKit,
                    .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                    .Project.DIContainer.DIContainer
                ] + exampleDependencies,
                settings: .settings(base: settings, configurations: XCConfig.feature)
                )
            
            projectTargets.append(example)
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
             textSettings: .textSettings(
                 indentWidth: 2,
                 tabWidth: 2
             )
            ),
            packages: packages,
            settings: .settings(base: settings, configurations: XCConfig.feature),
            targets: projectTargets
        )
    }
}
