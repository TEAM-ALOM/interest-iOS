//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let coreTarget = Target(
    name: "Core",
    platform: .iOS,
    product: .framework,
    bundleId: "interest.core",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
    ],
    settings: nil
)

let project = Project(
    name: "Core",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        coreTarget
    ]
)
