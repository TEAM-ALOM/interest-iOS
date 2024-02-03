//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain
import Dependencies
import SharedDesignSystem

public struct IntervalScreen: View {
    @State var router: IntervalRouter
    @State var viewModel: IntervalViewModel

    let intervalListScreen: IntervalListScreen
    
    public init(
        router: IntervalRouter,
        viewModel: IntervalViewModel
    ) {
        self._router = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: viewModel)
        
        self.intervalListScreen = .init(
            listViewModel: viewModel.intervalListViewModel
        )
                
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
