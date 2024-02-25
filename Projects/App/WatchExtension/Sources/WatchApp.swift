//
//  WatchApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import WatchKit
import Foundation
import SwiftData
import Feature
import Data

@main
struct WatchApp: App {
    @WKApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    let intervalRouter = IntervalRouter()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            IntervalScreen(router: intervalRouter,
                           viewModel: .init(router: intervalRouter))
                .modelContainer(for: [
                    IntervalPersistentModel.self,
                    IntervalRecordPersistentModel.self
                ])
        }
    }
}
