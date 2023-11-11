//
//  MainTabScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct MainTabScreen: View {
    
    @StateObject
    var bottomSheetFlowRouter = BottomSheetRouter()
    
    @StateObject
    var intervalRouter = IntervalRouter()
    
    @StateObject
    var viewModel: MainTabViewModel
    
    init(router: MainTabRouter) {
        self._viewModel = StateObject(wrappedValue: MainTabViewModel(router: router))
    }
    
    var body: some View {
        
        IntervalScreen(router: intervalRouter)
        
// Open버튼을 통해 bottomSheet가 올라오는 화면 임시 주석 처리
//        VStack(alignment: .leading) {
//            
//            Button("Open") {
//                viewModel.isBottomSheetPresent = true
//            }
//        }
//        .padding()
//        .sheet(isPresented: $viewModel.isBottomSheetPresent){
//            NavigationStack(path: $bottomSheetFlowRouter.navigationPath) {
//                Text("Bottom Sheet")
//            }
//        }
    }
}
