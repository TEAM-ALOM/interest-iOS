//
//  WatchApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import Presentation
import Data

@main
struct WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            IntervalScreen(
                intervalDIContainer: IntervalDIContainer(), 
                routerDIContainer: RouterDIContainer())
        }
    }
}
