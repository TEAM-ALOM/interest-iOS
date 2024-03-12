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
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            IntervalScreen(router: appDelegate.intervalRouter,
                           viewModel: .init(router: appDelegate.intervalRouter))
                .modelContainer(for: [
                    IntervalPersistentModel.self,
                    IntervalRecordPersistentModel.self
                ])
        }
    }
}
