//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

struct IntervalScreen: View {
    @StateObject private var intervalRouter: IntervalRouter
    @StateObject private var viewModel: IntervalViewModel
    
    private let intervalListScreen: IntervalListScreen
    
    init(router: IntervalRouter) {
        self._intervalRouter = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: IntervalViewModel(router: router))
        
        self.intervalListScreen = .init(router: router)
    }
    
    var body: some View {
        NavigationStack(path: $intervalRouter.navigationPath) {
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
                .sheet(isPresented: $viewModel.isBottomSheetPresent){
                    AddIntervalScreen(router: IntervalRouter())
                }
        }
    }
}

#Preview {
    NavigationStack {
        IntervalScreen(router: .init())
    }
}
