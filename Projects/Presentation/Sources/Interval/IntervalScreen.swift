//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

struct IntervalScreen: View {
    @StateObject private var viewModel: IntervalViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = StateObject(wrappedValue: IntervalViewModel(router: router))
    }
    
    @StateObject
    var bottomSheetFlowRouter = BottomSheetRouter()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.triggerTransition(route: .intervalDetail)
            }, label: {
                Text("인터벌 상세페이지 가기")
            })
        }
        .navigationTitle("인터레스트")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: IntervalRouter.PushRoute.self) { _ in
            viewModel.nextScreen()
        }
        .navigationBarItems(leading:
            Button(action: {
                viewModel.isBottomSheetPresent = true
            }, label: {
                Image(systemName: "plus")
                .foregroundStyle(.blue)
            })
            .sheet(isPresented: $viewModel.isBottomSheetPresent){
                NavigationStack(path: $bottomSheetFlowRouter.navigationPath) {
                    AddIntervalScreen(router: IntervalRouter())
                }
            })
    }
}

#Preview {
    NavigationStack {
        IntervalScreen(router: IntervalRouter())
    }
}
