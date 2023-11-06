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
    platform: .iOS,
    product: .framework,
    bundleId: "interest.shared",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
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
    platform: .iOS,
    product: .framework,
    bundleId: "interest.shared.thirdpartylib",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .default,
    sources: ["ThirdPartyLib/Sources/**"],
    dependencies: [
    ],
    settings: nil
)

let designSystemTarget = Target(
    name: "SharedDesignSystem",
    platform: .iOS,
    product: .framework,
    bundleId: "interest.shared.designSystem",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
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
