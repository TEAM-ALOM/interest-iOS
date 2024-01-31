//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain
import SharedDesignSystem

public struct IntervalScreen: View {
    let intervalDIContainer: IntervalDIContainerInterface
    @State var router: IntervalRouter
    @State var viewModel: IntervalViewModel

    let intervalListScreen: IntervalListScreen
//    let addIntervalScreen: AddIntervalScreen
    
    public init(
        intervalDIContainer: IntervalDIContainerInterface,
        routerDIContainer: RouterDIContainerInterface
    ) {
        let router = routerDIContainer.intervalRouter(intervalDIContainer: intervalDIContainer)
        
        self.intervalDIContainer = intervalDIContainer
        self._router = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: intervalDIContainer.intervalScreenDependencies(intervalRouter: router))
        
        self.intervalListScreen = .init(listViewModel: intervalDIContainer.intervalListDependencies(intervalRouter: router))
        
//        self.addIntervalScreen = .init(viewModel: intervalDIContainer.addIntervalDependencies(intervalRouter: router))
                
#if os(iOS)
        UIRefreshControl.appearance().tintColor = UIColor(Color.keyColor)
            
        let barAppearance = UINavigationBarAppearance()
        let style = UITraitCollection().userInterfaceStyle
        
        barAppearance.configureWithTransparentBackground()
        barAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.keyColor)]
        
        UINavigationBar.appearance().standardAppearance = barAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
        UINavigationBar.appearance().compactAppearance = barAppearance
#endif
    }

    public var body: some View {
#if os(iOS)
        iOS
#elseif os(watchOS)
        watchOS
#endif
    }
}
