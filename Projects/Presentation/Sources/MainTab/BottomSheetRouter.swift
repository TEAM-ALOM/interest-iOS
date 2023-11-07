//
//  BottomSheetFolwRouter.swift
//  Presentation
//
//  Created by 최유경 on 11/7/23.
//

import Foundation
import SwiftUI

public class BottomSheetRouter: ObservableObject, FlowRouter {
    public let id = UUID()
    
    @Published
    public var navigationPath: NavigationPath = .init()
    
    public var nextTransitionRoute: PushRoute = .unknown
    
    public func triggerScreenTransition(route: PushRoute) {
    }
    
    public func nextTransitionScreen() -> some View {
        Text("")
    }
    
    public enum PushRoute: Hashable {
        case unknown
    }
}
