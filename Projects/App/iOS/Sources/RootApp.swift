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
                routerDIContainer: RouterDIContainer()
            )
            .modelContainer(for: [
                IntervalPersistentModel.self,
                IntervalRecordPersistentModel.self
            ])
            .onAppear {
//                IntervalDataSource().save(title: "test1", exerciseType: .badminton, repeatCount: 0, burningSecondTime: 0, burningHeartIntervalType: .five, restingSecondTime: 0, restingHeartIntervalType: .four)
            }
        }
    }
}
