//
//  RootScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

public struct RootScreen: View {
    @StateObject var mainTabRouter: MainTabRouter = .init()
    
    public init(mainTabRouter: MainTabRouter) {
        self._mainTabRouter = .init(wrappedValue: mainTabRouter)
    }
    
    public var body: some View {
        NavigationStack(path: $mainTabRouter.navigationPath) {
            MainTabScreen(router: mainTabRouter)
        }
    }
}

//intervalScreen
//
//public struct RootScreen: View {
//    @StateObject var intervalRouter: IntervalRouter = .init()
//    
//    public init(intervalRouter: IntervalRouter) {
//        self._intervalRouter = .init(wrappedValue: intervalRouter)
//    }
//    
//    public var body: some View {
//        NavigationStack(path: $intervalRouter.navigationPath) {
//            IntervalScreen(router: intervalRouter)
//        }
//    }
//}
//#Preview {
//    RootScreen(intervalRouter: IntervalRouter())
//}
