//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/24.
//

import ProjectDescription

let SPM = SwiftPackageManagerDependencies([
    .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.2.1"))
])

let dependencies = Dependencies(
    swiftPackageManager: SPM,
    platforms: [.iOS, .watchOS]
)
