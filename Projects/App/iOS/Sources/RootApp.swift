//
//  RootApp.swift
//  InterestApp
//
//  Created by 송영모 on 11/2/23.
//

import SwiftUI
import Presentation
import Data

@main
public struct RootApp: App {
    let compositionRoot: CompositionRootInterface
    
    public init() {
        self.compositionRoot = CompositionRoot()
    }
    
    public var body: some Scene {
        WindowGroup {            
            IntervalScreen(intervalDIContainer: compositionRoot.intervalDIContainer)
                .modelContainer(for: [
                    IntervalPersistentModel.self,
                    IntervalRecordPersistentModel.self
                ])
        }
    }
}
