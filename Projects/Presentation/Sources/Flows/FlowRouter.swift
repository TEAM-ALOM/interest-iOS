//
//  FlowRouter.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI

public protocol FlowRouter: Hashable {
    associatedtype NavigationRoute: Hashable
    associatedtype PresentationRoute: Identifiable
    associatedtype NavigationScreen: View
    associatedtype PresentationScreen: View

    var id: UUID { get }

    var navigationPath: NavigationPath { get set }

    var nextNavigationRoute: NavigationRoute { get }
    var nextPresentationRoute: PresentationRoute? { get }

    func triggerNavigationScreen(navigationRoute: NavigationRoute)
    func triggerPresentationScreen(presentationRoute: PresentationRoute?)

    func nextNavigationScreen() -> NavigationScreen
    func nextPresentationScreen() -> PresentationScreen

}

public extension FlowRouter {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
