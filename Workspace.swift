import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let workspace = Workspace(
    name: "MoiverIOS",
    projects: ["Projects/*"],
    generationOptions: .options(
        enableAutomaticXcodeSchemes: false,
        autogeneratedWorkspaceSchemes: .disabled
    )
)