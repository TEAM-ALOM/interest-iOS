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
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .app,
    bundleId: "interest.app",
    deploymentTargets: .iOS("17.0"),
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
    destinations: [.appleWatch],
    product: .watch2App,
    bundleId: "interest.app.watch",
    deploymentTargets: .watchOS("10.0"),
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
    destinations: [.appleWatch],
    product: .watch2Extension,
    bundleId: "interest.app.watch.extension",
    deploymentTargets: .watchOS("10.0"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/WatchExtension/Resources/InterestWatchExtension-Info.plist")),
    sources: ["WatchExtension/Sources/**"],
    resources: ["WatchExtension/Resources/**"],
    dependencies: [
        .project(target: "Presentation", path: .relativeToRoot("Projects/Presentation")),
        .project(target: "Data", path: .relativeToRoot("Projects/Data")),
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
