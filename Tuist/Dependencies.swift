//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/24.
//

import ProjectDescription

let SPM = SwiftPackageManagerDependencies([
])

let dependencies = Dependencies(
    swiftPackageManager: SPM,
    platforms: [.iOS, .watchOS]
)
