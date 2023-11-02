//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Interest App target and Interest unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

//// Local plugin loaded
//let localHelper = LocalHelper(name: "MyPlugin")
//
//// Creates our project using a helper function defined in ProjectDescriptionHelpers
//let project = Project.app(name: "Interest",
//                          platform: .iOS,
//                          additionalTargets: ["InterestKit", "InterestUI"])


let appTarget = Target(
    name: "InterestApp",
    platform: .iOS,
    product: .app,
    productName: "",
    bundleId: "interest.app",
    deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone, .ipad], supportsMacDesignedForIOS: true),
    infoPlist: .default,
    sources: [],
    resources: [],
    dependencies: [],
    settings: nil
)

let project = Project(
    name: "InterestApp",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [appTarget]
)
