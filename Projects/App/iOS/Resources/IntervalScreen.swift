//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Presentation
import Domain
import Data

public struct IntervalScreen: View {
//    @StateObject private var intervalRouter: IntervalRouter
    @StateObject private var viewModel: IntervalViewModel
    
    private let intervalListScreen: IntervalListScreen
    
    public init(
        intervalDIContainer: IntervalDIContainerInterface
    ) {
        self._viewModel = .init(wrappedValue: intervalDIContainer.intervalScreenDependencies())
//        self._intervalRouter = .init(wrappedValue: router)
//        self._viewModel = .init(wrappedValue: viewModel)
        
        self.intervalListScreen = .init(router: .init(), intervalUseCase: IntervalUseCase(intervalRepository: IntervalRepository(dataSource: IntervalDataSource())))
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.router.navigationPath) {
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

//#Preview {
//    NavigationStack {
//        IntervalScreen(router: .init(), viewModel: .init(router: <#T##IntervalRouter#>, intervalUseCase: <#T##IntervalUseCaseInterface#>))
//    }
//}
