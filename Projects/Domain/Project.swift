//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let domainTarget = Target(
    name: "Domain",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.domain",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
    ],
    settings: nil
)

let project = Project(
    name: "Domain",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        domainTarget
    ]
)
