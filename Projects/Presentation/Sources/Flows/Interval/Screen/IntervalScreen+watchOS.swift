//
//  IntervalScreen+watchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import SwiftUI
import SharedDesignSystem

public extension IntervalScreen {
    var watchOS: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                intervalListScreen
            }
            .navigationTitle("인터레스트")
            .navigationDestination(for: IntervalRouter.PushRoute.self) { _ in
                viewModel.nextScreen()
            }
        }
        .tint(Color.keyColor)
    }
}
