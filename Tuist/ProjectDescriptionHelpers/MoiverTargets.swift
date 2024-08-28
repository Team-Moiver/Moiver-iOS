//
//  MoiverTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 8/28/24.
//

import Foundation
import ProjectDescription

extension Target {
    enum MoiverTargets {
        case moiver(String, Platform, String, [TargetDependency])
    }
    
}

extension Target.MoiverTargets {
    var target: Target {
        switch self {
        case .moiver(
            let name,
            let platform,
            let iOSTargetVersion,
            let dependencies
        ):
            return self.makeMoiverTarget(name, platform, iOSTargetVersion, dependencies)
        }
    }
}
