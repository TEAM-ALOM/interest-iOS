//
//  WatchFlowRouter.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

public protocol WatchFlowRouter: Hashable {
    associatedtype PushRoute: Hashable
    associatedtype NextScreen: View
    
    var id: UUID { get }
    
    var navigationPath: NavigationPath { get set }
    
    var nextTransitionRoute: PushRoute { get }
    
    func triggerScreenTransition(route: PushRoute)
    func nextTransitionScreen() -> NextScreen
}

public extension WatchFlowRouter {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
