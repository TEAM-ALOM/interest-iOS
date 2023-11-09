//
//  MainTabRouter.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

public final class MainTabRouter: ObservableObject, FlowRouter {
    public let id = UUID()
    
    public init() { }
    
    @Published public var navigationPath: NavigationPath = .init()
    
    public var nextTransitionRoute: PushRoute = .open
    
    public func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }
    
    public func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(router: self)
    }
}

public extension MainTabRouter {
    enum PushRoute: Hashable {
        case open
        
        func nextView(router: MainTabRouter) -> some View {
            switch self {
            case .open:
                return MainTabScreen(router: MainTabRouter())
            }
        }
    }
}
