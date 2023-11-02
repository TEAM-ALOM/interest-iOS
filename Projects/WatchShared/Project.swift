//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let watchShared = Target(
    name: "WatchShared",
    platform: .watchOS,
    product: .framework,
    bundleId: "interest.watchshared",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    dependencies: [
        .target(name: "WatchSharedThirdPartyLib")
    ],
    settings: nil
)

let watchThirdPartyLibTarget = Target(
    name: "WatchSharedThirdPartyLib",
    platform: .watchOS,
    product: .framework,
    bundleId: "interest.watchshared.thirdpartylib",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["ThirdPartyLib/Sources/**"],
    dependencies: [
        .external(name: "ComposableArchitecture")
    ],
    settings: nil
)


let project = Project(
    name: "WatchShared",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        watchShared,
        watchThirdPartyLibTarget
    ]
)
