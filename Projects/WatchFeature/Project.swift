//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let watchFeatureTarget = Target(
    name: "WatchFeature",
    platform: .watchOS,
    product: .framework,
    bundleId: "interest.watch.extension.feature",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "WatchDomain", path: .relativeToRoot("Projects/WatchDomain")),
    ],
    settings: nil
)

let project = Project(
    name: "WatchFeature",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        watchFeatureTarget
    ]
)
