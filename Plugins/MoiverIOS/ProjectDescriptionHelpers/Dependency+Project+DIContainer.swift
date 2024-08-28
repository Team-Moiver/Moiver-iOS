//
//  Dependency+Project+DIContainer.swift
//  UtilityPlugin
//
//  Created by mincheol on 11/9/23.
//

import Foundation

public extension Dep.Project.DIContainer {
    static let group = "DIContainer"
    static let DIContainer: Dep = .project(target: "\(group)", path: .relativeToRoot("Projects/\(group)"))
}
