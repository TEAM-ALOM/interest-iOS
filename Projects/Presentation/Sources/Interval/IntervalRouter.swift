//
//  IntervalRouter.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

import Domain

public final class IntervalRouter: ObservableObject, FlowRouter {
    public let id = UUID()
    
    public init(intervalDIContainer: IntervalDIContainerInterface) {
        self.intervalDIContainer = intervalDIContainer
    }
    
    @Published public var navigationPath: NavigationPath = .init()
    
    public var nextTransitionRoute: PushRoute = .intervalDetail
    
    private let intervalDIContainer: IntervalDIContainerInterface
    
    public func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }
    
    public func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(intervalDIContainer: self.intervalDIContainer, router: self)
    }
}

public extension IntervalRouter {
    enum PushRoute: Hashable {
        case intervalList
        case intervalDetail
        case intervalActive
       
        @ViewBuilder
        func nextView(intervalDIContainer: IntervalDIContainerInterface, router: IntervalRouter) -> some View {
            switch self {
            case .intervalList:
                let viewModel = intervalDIContainer.intervalListDependencies(intervalRouter: router)
                IntervalListScreen(viewModel: viewModel)
            case .intervalDetail:
                let viewModel = intervalDIContainer.intervalDetailDependencies(intervalRouter: router)
                IntervalDetailScreen(viewModel: viewModel)
            case .intervalActive:
                let viewModel = intervalDIContainer.intervalActiveDependencies(intervalRouter: router)
                IntervalActiveScreen(viewModel: viewModel)
            }
        }
    }
}
