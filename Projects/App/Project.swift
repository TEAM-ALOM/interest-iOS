//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let appTarget = Target(
    name: "InterestApp",
    platform: .iOS,
    product: .app,
    productName: "InterestApp",
    bundleId: "interest.app",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .default,
    sources: ["iOS/Sources/**"],
    resources: ["iOS/Resources/**"],
    dependencies: [
        .target(name: "InterestWatch")
    ],
    settings: nil
)

let watchTarget = Target(
    name: "InterestWatch",
    platform: .watchOS,
    product: .watch2App,
    productName: "InterestWatch",
    bundleId: "interest.app.watch",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: nil,
    resources: nil,
    dependencies: [
        .target(name: "InterestWatchExtension")
    ],
    settings: nil
)

let watchExtensionTarget = Target(
    name: "InterestWatchExtension",
    platform: .watchOS,
    product: .watch2Extension,
    productName: "InterestWatchExtension",
    bundleId: "interest.app.watch.extension",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .default,
    sources: ["WatchExtension/Sources/**"],
    resources: ["WatchExtension/Resources/**"],
    dependencies: [
        
    ],
    settings: nil
)


let project = Project(
    name: "Interest",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        appTarget,
        watchTarget,
        watchExtensionTarget
    ]
)
