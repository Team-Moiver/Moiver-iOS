//
//  MoiverCore.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 8/28/24.
//

import Foundation
import ProjectDescription

public enum MoiverCore {
    
    /// Envoriment와 BuildMode를 조합해 [Scheme]을  반환합니다.
    public static var schemes: [Scheme] {
        return Enviroment.allCases.compactMap { env in
            return self.makeScheme(env)
        }
    }
    
    static func makeScheme(_ env: Enviroment) -> Scheme {
        let name = env.rawValue
        let configuration = ConfigurationName.configuration(name)
        return .init(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["Moiver"]),
            testAction: .targets(
                ["Moiver"],
                configuration: configuration
            ),
            runAction: .runAction(
                configuration: configuration,
                arguments: .init(
                    environment: [
                        "OS_ACTIVITY_MODE": "disable"
                    ])
            ),
            archiveAction: .archiveAction(configuration: configuration),
            profileAction: .profileAction(configuration: configuration),
            analyzeAction: .analyzeAction(configuration: configuration)
        )
    }
    
    public static var configurations: [Configuration] {
        return Enviroment.allCases.compactMap { env in
            let config = ConfigurationName.configuration(env.rawValue)
            switch env {
            case .product_release:
                return .release(name: config, xcconfig: (env.xcconfing))
            case .product_debug:
                return .debug(name: config, xcconfig: (env.xcconfing))
            }
        }
    }
}

extension MoiverCore {
    enum Enviroment: String, CaseIterable {
        case product_release = "Product-Release"
        case product_debug = "Product-Debug"
        
        var xcconfing: Path {
            switch self {
            case .product_release:
                return .relativeToManifest("Resources/SupportFiles/ConfigurationSettings/Product-Release.xcconfig")
            case .product_debug:
                return .relativeToManifest("Resources/SupportFiles/ConfigurationSettings/Product-Debug.xcconfig")
            }
        }
    }
}

extension MoiverCore {
    enum Constants {
        
        /// Moiver(Target)을 구성하기 위해 필요한 Settings를 반환합니다.
        public static let settingsTargetMoiver: Settings = .settings(
            base: [
                "CODE_SIGN_STYLE": "Automatic",
//                "DEVELOPMENT_TEAM": "5UGTTL8VT9",
                "INFOPLIST_FILE": "Info.plist",
                "TARGETED_DEVICE_FAMILY": "1",
                "ASSETCATALOG_COMPILER_APPICON_NAME": "${ICON_NAME}",
                "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
                "CLANG_ENABLE_CODE_COVERAGE": "NO"
            ]
        )
    }
    
}
