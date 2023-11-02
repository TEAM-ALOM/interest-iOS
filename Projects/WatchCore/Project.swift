//
//  WatchCore.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let watchCoreTarget = Target(
    name: "WatchCore",
    platform: .watchOS,
    product: .framework,
    bundleId: "interest.watch.extension.core",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "WatchShared", path: .relativeToRoot("Projects/WatchShared")),
    ],
    settings: nil
)

let project = Project(
    name: "WatchCore",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        watchCoreTarget
    ]
)
