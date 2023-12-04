//
//  IntervalScreen+iOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import SwiftUI

public extension IntervalScreen {
    var iOS: some View {
        NavigationStack(path: $router.navigationPath) {
            intervalListScreen
                .navigationTitle("인터레스트")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            viewModel.isBottomSheetPresent = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .navigationDestination(for: IntervalRouter.PushRoute.self) { _ in
                    viewModel.nextScreen()
                }
                .sheet(isPresented: $viewModel.isBottomSheetPresent) {
                    AddIntervalScreen(viewModel: intervalDIContainer.addIntervalDependencies(intervalRouter: router))
                }
        }
    }
}
