//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let shared = Target(
    name: "Shared",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.shared",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    dependencies: [
        .target(name: "SharedThirdPartyLib"),
        .target(name: "SharedDesignSystem")
    ],
    settings: nil
)

let thirdPartyLibTarget = Target(
    name: "SharedThirdPartyLib",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.shared.thirdpartylib",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["ThirdPartyLib/Sources/**"],
    dependencies: [
    ],
    settings: nil
)

let designSystemTarget = Target(
    name: "SharedDesignSystem",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.shared.designSystem",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["DesignSystem/Sources/**"],
    resources: ["DesignSystem/Resources/**"],
    dependencies: [

    ],
    settings: nil
)

let project = Project(
    name: "Shared",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        shared,
        thirdPartyLibTarget,
        designSystemTarget,
    ]
)
