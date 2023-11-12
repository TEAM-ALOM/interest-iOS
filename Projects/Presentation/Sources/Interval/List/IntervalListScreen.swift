//
//  IntervalListScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct IntervalListScreen: View {
    @StateObject var viewModel: IntervalListViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = .init(wrappedValue: IntervalListViewModel())
    }
    
    var body: some View {
        ScrollView {
            Button(action: {
                viewModel.triggerTransition(route: .intervalDetail)
            }, label: {
                Text("인터벌 상세페이지 가기")
            })
        }
    }
}
