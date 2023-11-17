//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain

public struct IntervalScreen: View {
    @StateObject private var router: IntervalRouter
    @StateObject private var viewModel: IntervalViewModel
    
    private let intervalListScreen: IntervalListScreen
    private let addIntervalScreen: AddIntervalScreen
    
    public init(
        intervalDIContainer: IntervalDIContainerInterface
    ) {
        let router = intervalDIContainer.intervalRouter()
        
        self._router = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: intervalDIContainer.intervalScreenDependencies(intervalRouter: router))
        
        self.intervalListScreen = .init(viewModel: intervalDIContainer.intervalListDependencies(intervalRouter: router))
        self.addIntervalScreen = .init(viewModel: intervalDIContainer.addIntervalDependencies(intervalRouter: router))
    }
    
    public var body: some View {
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
                    addIntervalScreen
                }
        }
    }
}
