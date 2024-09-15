import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let iOSTargetVersion = "17.0"

let project = Project.feature(
    name: "Community",
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [],
    exampleDependencies: []
)
