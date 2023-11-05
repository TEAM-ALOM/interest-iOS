//
//  WatchApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI

import WatchFeature

@main
struct WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            WatchFeatureView()
        }
    }
}
