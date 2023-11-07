//
//  FlowRouter.swift
//  Feature
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

public protocol FlowRouter: Hashable {
    associatedtype PushRoute: Hashable
    associatedtype NextScreen: View

    var id: UUID { get }

    var navigationPath: NavigationPath { get set }

    var nextTransitionRoute: PushRoute { get set }

    func triggerScreenTransition(route: PushRoute)
    func nextTransitionScreen() -> NextScreen
}

public extension FlowRouter {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
