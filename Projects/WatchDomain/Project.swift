//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let watchDomainTarget = Target(
    name: "WatchDomain",
    platform: .watchOS,
    product: .framework,
    bundleId: "interest.watch.extension.domain",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "WatchCore", path: .relativeToRoot("Projects/WatchCore")),
    ],
    settings: nil
)

let project = Project(
    name: "WatchDomain",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        watchDomainTarget
    ]
)
