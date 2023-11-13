//
//  RootApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import Presentation

@main
struct iOSApp: App {
    var body: some Scene {
        WindowGroup {
            IntervalScreen(intervalDIContainer: IntervalDIContainer())
        }
    }
}
