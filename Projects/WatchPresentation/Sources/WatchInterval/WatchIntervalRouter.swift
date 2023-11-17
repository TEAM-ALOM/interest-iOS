//
//  WatchIntervalRouter.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI
import WatchDomain

public final class WatchIntervalRouter: ObservableObject, WatchFlowRouter {
    public let id = UUID()
    
    public init(watchIntervalDIContainer: WatchIntervalDIContainerInterface) {
        self.watchIntervalDIContainer = watchIntervalDIContainer
    }
    
    @Published public var navigationPath: NavigationPath = .init()
    
    public var nextTransitionRoute: PushRoute = .intervalActive
    
    private let watchIntervalDIContainer: WatchIntervalDIContainerInterface
    
    public func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }
    
    public func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(watchIntervalDIContainer: self.watchIntervalDIContainer, router: self)
    }
}

public extension WatchIntervalRouter {
    enum PushRoute: Hashable {
        case intervalActive
        
        @ViewBuilder
        func nextView(watchIntervalDIContainer: WatchIntervalDIContainerInterface, router: WatchIntervalRouter) -> some View {
            switch self {
            case .intervalActive:
                IntervalBurningScreen(viewModel: watchIntervalDIContainer.watchIntervalBurningDependencies(intervalRouter: router))
            }
        }
    }
}
