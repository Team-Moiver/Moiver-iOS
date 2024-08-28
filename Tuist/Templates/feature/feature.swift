//
//  Templates.swift
//  UtilityPlugin
//
//  Created by mincheol on 2023/05/10.
//

import ProjectDescription

private let nameAttribute: Template.Attribute = .required("name")

private let template = Template(
    description: "Feature template",
    attributes: [nameAttribute, .optional("platform", default: "iOS")],
    items: [
        [
            .file(path: "\(nameAttribute)/Interface/Sources/\(nameAttribute).swift",
                  templatePath: "contents_feature_source.stencil"),
            .string(path: "\(nameAttribute)/Interface/Resources/dummy.txt",
                    contents: "_")
        ],
        [
            .file(path: "\(nameAttribute)/Implementation/Sources/\(nameAttribute).swift",
                  templatePath: "contents_feature_source.stencil"),
            .string(path: "\(nameAttribute)/Implementation/Resources/dummy.txt",
                    contents: "_")
        ],
        [
            .file(path: "\(nameAttribute)/Model/Sources/\(nameAttribute).swift",
                  templatePath: "contents_feature_source.stencil"),
            .string(path: "\(nameAttribute)/Model/Resources/dummy.txt",
                    contents: "_")
        ],
        [
            .file(path: "\(nameAttribute)/UI/Sources/\(nameAttribute).swift",
                  templatePath: "contents_feature_source.stencil"),
            .string(path: "\(nameAttribute)/UI/Resources/dummy.txt",
                    contents: "_")
        ],
        [
            .file(path: "\(nameAttribute)/Example/Sources/AppDelegate.swift",
                  templatePath: "contents_example_appdelegate.stencil"),
            .file(path: "\(nameAttribute)/Example/Resources/Assets.xcassets/contents.json",
                  templatePath: "contents_xcassets.stencil"),
            .file(path: "\(nameAttribute)/Example/Resources/Assets.xcassets/AppIcon.appiconset/contents.json",
                  templatePath: "contents_xcassetsAppIcon.stencil")
        ],
        [
            .file(path: "\(nameAttribute)/Project.swift",
                  templatePath: "contents_project.stencil")
        ]
    ].flatMap { $0 }
)
