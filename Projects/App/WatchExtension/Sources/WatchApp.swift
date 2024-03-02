//
//  WatchApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import WatchKit

import Feature
import Data

@main
struct WatchApp: App {
    @WKApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    let intervalRouter: IntervalRouter = .init()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            IntervalScreen(
                router: intervalRouter,
                viewModel: .init(router: intervalRouter)
            )
            .onAppear() {
                appDelegate.subsrcibeStartedInterval()
                appDelegate.subscribeStartWatchAppFromiPhone()
            }
        }
    }
}
