//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

//let presentationTarget = Target(
//    name: "Presentation",
//    platform: .iOS,
//    product: .framework,
//    bundleId: "interest.presentation",
//    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
//    infoPlist: .default,
//    sources: ["Sources/**"],
//    resources: ["Resources/**"],
//    dependencies: [
//        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
//    ],
//    settings: nil
//)

let presentationTarget = Target(
    name: "Presentation",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.presentation",
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
