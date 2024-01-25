//
//  IntervalScreen+iOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import SwiftUI
import SharedDesignSystem

public extension IntervalScreen {
    var iOS: some View {
        NavigationStack(path: $router.navigationPath) {
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
                .navigationDestination(for: IntervalRouter.NavigationRoute.self) { _ in
                    viewModel.nextScreen()
                }
                .sheetWithRouter(router: self.router)
        }
        .tint(Color.keyColor)
    }
}
