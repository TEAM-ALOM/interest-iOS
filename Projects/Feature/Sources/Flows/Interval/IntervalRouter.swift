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
    public typealias NavigationRoute = NavigationRouteType
    public let id = UUID()
    
    public init() { }
    
    public var navigationPath: NavigationPath = .init()
    public var nextNavigationRoute: NavigationRoute? = nil
    public var nextPresentationRoute: PresentationRoute? = nil
    
    public func triggerNavigationScreen(navigationRoute: NavigationRoute?) {
        nextNavigationRoute = navigationRoute
        if let navigationRoute = navigationRoute {
            navigationPath.append(navigationRoute)
        } else {
            navigationPath.removeLast()
        }
    }

    public func triggerPresentationScreen(presentationRoute: PresentationRoute?) {
        nextPresentationRoute = presentationRoute
    }

    public func nextNavigationScreen() -> some View {
        nextNavigationRoute?.nextView
    }

    public func nextPresentationScreen() -> some View {
        nextPresentationRoute?.nextView
    }
    
    public func removeScreenTransition() {
        navigationPath.removeLast()
    }
}

public extension IntervalRouter {
    enum NavigationRouteType: Hashable {
        case intervalList(IntervalListViewModel)
        case intervalDetail(IntervalDetailViewModel)
        case intervalActive (IntervalActiveViewModel)
       
        @ViewBuilder
        var nextView: some View {
            switch self {
            case let .intervalList(vm):
                IntervalListScreen(listViewModel: vm)
            case let .intervalDetail(vm):
                IntervalDetailScreen(viewModel: vm)
            case let .intervalActive(vm):
                IntervalActiveScreen(viewModel: vm)
            }
        }
        
        var id: UUID {
            switch self {
            case let .intervalList(model): model.id
            case .intervalDetail: .init()
            case .intervalActive: .init()
            }
        }
        
        public static func == (lhs: IntervalRouter.NavigationRouteType, rhs: IntervalRouter.NavigationRouteType) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    enum PresentationRoute: Hashable {
        case addInterval(AddIntervalViewModel)
        case editInterval(EditIntervalViewModel)

        @ViewBuilder
        var nextView: some View {
            switch self {
            case let .addInterval(vm):
                AddIntervalScreen(viewModel: vm)
                
            case let .editInterval(vm):
                EditIntervalScreen(viewModel: vm)
            }
        }

        public var id: UUID { return .init() }
        
        public static func == (lhs: IntervalRouter.PresentationRoute, rhs: IntervalRouter.PresentationRoute) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
