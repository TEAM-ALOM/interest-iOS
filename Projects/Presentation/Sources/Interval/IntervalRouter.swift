//
//  IntervalRouter.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

final class IntervalRouter: ObservableObject, FlowRouter {
    let id = UUID()
    
    @Published var navigationPath: NavigationPath = .init()
    
    private(set) var nextTransitionRoute: PushRoute = .interval
    
    func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }
    
    func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(router: self)
    }
}

extension IntervalRouter {
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
