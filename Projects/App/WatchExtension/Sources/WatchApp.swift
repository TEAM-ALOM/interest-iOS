//
//  WatchApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import WatchPresentation

@main
struct WatchApp: App {
    let compositionRoot: CompositionRootInterface
    
    public init() {
        self.compositionRoot = CompositionRoot()
    }
    @SceneBuilder var body: some Scene {
        WindowGroup {
            WatchIntervalScreen(watchIntervalDIContainer: compositionRoot.intervalDIContainer)
        }
    }
}
