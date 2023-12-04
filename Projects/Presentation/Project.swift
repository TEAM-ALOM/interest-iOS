//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let presentationTarget = Target(
    name: "Presentation",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.presentation",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
    ]
)

let project = Project(
    name: "Presentation",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        presentationTarget
    ]
)
