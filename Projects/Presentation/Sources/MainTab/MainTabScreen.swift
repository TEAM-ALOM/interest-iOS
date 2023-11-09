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
    var viewModel: MainTabViewModel
    
    init(router: MainTabRouter) {
        self._viewModel = StateObject(wrappedValue: MainTabViewModel(router: router))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button("Open") {
                viewModel.isBottomSheetPresent = true
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.isBottomSheetPresent){
            NavigationStack(path: $bottomSheetFlowRouter.navigationPath) {
                Text("Bottom Sheet")
            }
        }
    }
}
