//
//  RootApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI

import Dependencies

import Feature
import Data

@main
public struct RootApp: App {
    let intervalRouter = IntervalRouter()
    
    public init() { }
    
    public var body: some Scene {
        WindowGroup {
            IntervalScreen(
                router: intervalRouter,
                viewModel: withDependencies({
                        $0.prepare()
                }, operation: {
                    IntervalViewModel(router: intervalRouter)
                })
            )
            .modelContainer(for: [
                IntervalPersistentModel.self,
                IntervalRecordPersistentModel.self
            ])
        }
    }
}
