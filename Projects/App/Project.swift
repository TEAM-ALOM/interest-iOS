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
//    platform: .iOS,
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .app,
    bundleId: "interest.app",
//    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .file(path: .relativeToRoot("Projects/App/iOS/Resources/InterestApp-Info.plist")),
    sources: ["iOS/Sources/**"],
    resources: ["iOS/Resources/**"],
    dependencies: [
        .target(name: "InterestWatch"),
        .project(target: "Presentation", path: .relativeToRoot("Projects/Presentation")),
        .project(target: "Data", path: .relativeToRoot("Projects/Data")),
    ],
    settings: nil
)


let watchTarget = Target(
    name: "InterestWatch",
    platform: .watchOS,
    product: .watch2App,
    bundleId: "interest.app.watch",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/WatchExtension/Resources/InterestWatch-Info.plist")),
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
    bundleId: "interest.app.watch.extension",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/WatchExtension/Resources/InterestWatchExtension-Info.plist")),
    sources: ["WatchExtension/Sources/**"],
    resources: ["WatchExtension/Resources/**"],
    dependencies: [
        .project(target: "Presentation", path: .relativeToRoot("Projects/Presentation")),
        .project(target: "Data", path: .relativeToRoot("Projects/Data")),
        .project(target: "WatchPresentation", path: .relativeToRoot("Projects/WatchPresentation")),
        .project(target: "WatchData", path: .relativeToRoot("Projects/WatchData"))
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
