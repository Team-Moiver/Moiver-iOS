import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let iOSTargetVersion = "17.2"

let project = Project.feature(
    name: "Home",
    platform: .iOS,
    targets: [.dynamicFramework],
    iOSTargetVersion: iOSTargetVersion,
    dependencies: [],
    exampleDependencies: []
)
