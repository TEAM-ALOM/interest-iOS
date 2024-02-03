//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2/3/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let featureTarget = Target(
    name: "Feature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "interest.feature",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Presentation", path: .relativeToRoot("Projects/Presentation")),
        .project(target: "Data", path: .relativeToRoot("Projects/Data")),
    ]
)

let project = Project(
    name: "Feature",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        featureTarget
    ]
)
