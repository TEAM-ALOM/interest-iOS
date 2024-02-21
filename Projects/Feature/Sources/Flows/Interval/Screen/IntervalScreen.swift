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

    @State var intervalListScreen: IntervalListScreen
    
    public init(
        router: IntervalRouter,
        viewModel: IntervalViewModel
    ) {
        self._router = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: viewModel)
        
        self.intervalListScreen = .init(listViewModel: viewModel.intervalListViewModel)
                
#if os(iOS)
        UIRefreshControl.appearance().tintColor = UIColor(Color.keyColor)
            
        let barAppearance = UINavigationBarAppearance()
        
        barAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.textColor)
        ]
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.keyColor)]
        
        UINavigationBar.appearance().standardAppearance = barAppearance
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

private extension IntervalScreen {
    var iOS: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                intervalListScreen
                    .navigationTitle("인터레스트")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                viewModel.tapPlusButton()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                    .navigationDestination(for: IntervalRouter.NavigationRoute.self) { route in
                        route.nextView
                    }
                    .sheetWithRouter(router: self.router)
            }
        }
        .tint(Color.keyColor)
    }
    
    var watchOS: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                intervalListScreen
            }
            .navigationTitle("인터레스트")
            .navigationDestination(for: IntervalRouter.NavigationRoute.self) { route in
                route.nextView
            }
        }
        .tint(Color.keyColor)
    }
}

#Preview {
    IntervalScreen(router: .init(), viewModel: .init(router: .init()))
}
