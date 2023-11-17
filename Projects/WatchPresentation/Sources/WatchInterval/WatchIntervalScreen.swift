//
//  WatchIntervalScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI
import WatchDomain

public struct WatchIntervalScreen: View {
    @StateObject private var router: WatchIntervalRouter
    @StateObject private var viewModel: WatchIntervalViewModel
    
    private let intervalBurningScreen: IntervalBurningScreen
    private let intervalSelectScreen: IntervalSelectScreen
    
    public init(
        watchIntervalDIContainer: WatchIntervalDIContainerInterface
    ) {
        let router = watchIntervalDIContainer.watchIntervalRouter()
        
        self._router = .init(wrappedValue: router)
        
        self._viewModel = .init(wrappedValue: watchIntervalDIContainer.watchIntervalScreenDependencies(intervalRouter: router))
        
        self.intervalBurningScreen = .init(viewModel: watchIntervalDIContainer.watchIntervalBurningDependencies(intervalRouter: router))
        
        self.intervalSelectScreen = .init(viewModel: watchIntervalDIContainer.watchIntervalSelectDependencies(intervalRouter: router))
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationPath) {
            intervalSelectScreen
                .navigationDestination(for: WatchIntervalRouter.PushRoute.self) { _ in
                    viewModel.nextScreen()
                }
            
        }
    }
    
}