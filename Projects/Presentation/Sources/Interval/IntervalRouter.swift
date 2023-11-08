//
//  IntervalRouter.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

public final class IntervalRouter: ObservableObject, FlowRouter {
    public let id = UUID()
    
    public init() { }
    
    @Published public var navigationPath: NavigationPath = .init()
    
    public var nextTransitionRoute: PushRoute = .interval
    
    public func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }
    
    public func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(router: self)
    }
}

public extension IntervalRouter {
    enum PushRoute: Hashable {
        case interval
        case intervalDetail
       
        @ViewBuilder
        func nextView(router: IntervalRouter) -> some View {
            switch self {
            case .interval:
                IntervalScreen(router: router)
            case .intervalDetail:
                IntervalDetailScreen(router: router)
            }
        }
    }
}
