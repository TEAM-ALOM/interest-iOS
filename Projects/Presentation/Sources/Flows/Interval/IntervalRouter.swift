//
//  IntervalRouter.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

import Domain

@Observable
public final class IntervalRouter: FlowRouter {
    public let id = UUID()
    
    public init(intervalDIContainer: IntervalDIContainerInterface) {
        self.intervalDIContainer = intervalDIContainer
    }
    
    public var navigationPath: NavigationPath = .init()
    public var nextNavigationRoute: NavigationRoute = .intervalList
    public var nextPresentationRoute: PresentationRoute? = nil

    private let intervalDIContainer: IntervalDIContainerInterface
    
    public func triggerNavigationScreen(navigationRoute: NavigationRoute) {
        navigationPath.append(navigationRoute)
        nextNavigationRoute = navigationRoute
    }

    public func triggerPresentationScreen(presentationRoute: PresentationRoute?) {
        nextPresentationRoute = presentationRoute
    }

    public func nextNavigationScreen() -> some View {
        nextNavigationRoute.nextView(intervalDIContainer: self.intervalDIContainer, router: self)
    }

    public func nextPresentationScreen() -> some View {
        nextPresentationRoute?.nextView(intervalDIContainer: self.intervalDIContainer, router: self)
    }
}

public extension IntervalRouter {
    enum NavigationRoute: Hashable {
        case intervalList
        case intervalDetail(IntervalModel)
        case intervalActive
       
        @ViewBuilder
        func nextView(intervalDIContainer: IntervalDIContainerInterface, router: IntervalRouter) -> some View {
            switch self {
            case .intervalList:
                let viewModel = intervalDIContainer.intervalListDependencies(intervalRouter: router)
                IntervalListScreen(viewModel: viewModel)
            case .intervalDetail(let intervalItem):
                let viewModel = intervalDIContainer.intervalDetailDependencies(intervalRouter: router, intervalItem: intervalItem)
                IntervalDetailScreen(viewModel: viewModel)
            case .intervalActive:
                let viewModel = intervalDIContainer.intervalActiveDependencies(intervalRouter: router)
                IntervalActiveScreen(viewModel: viewModel)
            }
        }
    }

    enum PresentationRoute: Identifiable {
        case addInterval
        case editInterval(Binding<IntervalModel>)

        @ViewBuilder
        func nextView(intervalDIContainer: IntervalDIContainerInterface, router: IntervalRouter) -> some View {
            switch self {
            case .addInterval:
                AddIntervalScreen(viewModel: intervalDIContainer.addIntervalDependencies(intervalRouter: router, intervalItem: nil))
            case let .editInterval(item):
                AddIntervalScreen(viewModel: intervalDIContainer.addIntervalDependencies(intervalRouter: router, intervalItem: item))
            }
        }

        public var id: UUID { return .init() }
    }
}
