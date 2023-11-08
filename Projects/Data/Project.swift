//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let dataTarget = Target(
    name: "Data",
    platform: .iOS,
    product: .framework,
    bundleId: "interest.data",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
    ],
    settings: nil
)

let project = Project(
    name: "Data",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        dataTarget
    ]
)