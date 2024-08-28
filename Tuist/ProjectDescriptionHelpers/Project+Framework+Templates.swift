import ProjectDescription
import UtilityPlugin

extension Project {
    public static func app(name: String,
                           platform: Platform,
                           packages: [Package] = [],
                           iOSTargetVersion: String,
                           settings: Settings,
                           infoPlist: String,
                           dependencies: [TargetDependency] = []) -> Project {
        let targets = makeAppTargets(name: name,
                                     platform: platform,
                                     iOSTargetVersion: iOSTargetVersion,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        
        return Project(name: name,
                       organizationName: organizationName,
                       options: .options(
                        textSettings: .textSettings(
                            indentWidth: 2,
                            tabWidth: 2
                        )
                       ),
                       packages: packages,
                       settings: settings,
                       targets: targets,
                       schemes: MoiverCore.schemes
        )
    }
    
    public static func framework(name: String,
                                 platform: Platform,
                                 targets: Set<FeatureTarget> = Set([.staticLibrary]),
                                 iOSTargetVersion: String,
                                 packages: [Package] = [],
                                 dependencies: [TargetDependency] = []) -> Project {
        let targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           targets: targets,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
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
            settings: .settings(configurations: XCConfig.framework),
            targets: targets
        )
    }
    
    
}

private extension Project {
    
    static func makeFrameworkTargets(
        name: String,
        platform: Platform,
        targets: Set<FeatureTarget> = Set([.staticLibrary]),
        iOSTargetVersion: String,
        dependencies: [TargetDependency] = []
    ) -> [Target] {
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        var settings: SettingsDictionary
        
        let sources: SourceFilesList
        let resources: ResourceFileElements
        
        settings = hasDynamicFramework
        ? ["OTHER_LDFLAGS" : "$(inherited) -all_load", "ONLY_ACTIVE_ARCH": "NO"]
        : ["OTHER_LDFLAGS" : "$(inherited)", "ONLY_ACTIVE_ARCH": "NO"]
        sources = ["Sources/**"]
        resources = ["Resources/**"]
        
        var projectTargets: [Target] = []
        
        let target = Target(
            name: name,
            platform: platform,
            product: hasDynamicFramework ? .framework : .staticLibrary,
            bundleId: "kr.co.Moiver.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: .default,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: .settings(base: settings, configurations: XCConfig.framework)
        )
        
        projectTargets.append(target)
        
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
                    .target(name: "\(name)"),
                    .Project.Core.MoiverCoreKit.MoiverCoreKit,
                    .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                    .Project.DIContainer.DIContainer
                ],
                settings: .settings(base: settings.merging([
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "5UGTTL8VT9"
                ]), configurations: XCConfig.framework)
            )
            projectTargets.append(example)
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
                dependencies: [
                    .target(name: "\(name)"),
                    .package(product: "RxTest"),
                    .Project.Core.MoiverCoreKit.MoiverCoreKit,
                    .Project.Core.MoiverThirdPartyLibManager.MoiverThirdPartyLibManager,
                    .Project.DIContainer.DIContainer
                ],
                settings: .settings(
                    base: settings,
                    configurations: XCConfig.framework
                )
            )
            projectTargets.append(testTarget)
        }
        
        return projectTargets
    }
    
    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: [String: InfoPlist.Value] = [:], dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target (
            name: name,
            platform: platform,
            product: .app,
            productName: name,
            bundleId: "${PRODUCT_BUNDLE_IDENTIFIER}",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: .init(),
            dependencies: dependencies,
            settings: MoiverCore.Constants.settingsTargetMoiver
        )
        
        return [mainTarget]
    }
    
    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: String, dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target.MoiverTargets
            .moiver(name, platform, iOSTargetVersion, dependencies)
            .target
        
        return [mainTarget]
    }
}
