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
    public init() { }
    
    public var body: some Scene {
        WindowGroup {            
            IntervalScreen(
                intervalDIContainer: IntervalDIContainer(),
                routerDIContainer: RouterDIContainer())
                .modelContainer(for: [
                    IntervalPersistentModel.self,
                    IntervalRecordPersistentModel.self
                ])
        }
    }
}
