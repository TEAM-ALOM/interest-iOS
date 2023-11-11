//
//  IntervalListScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct IntervalListScreen: View {
    @ObservedObject var viewModel: IntervalListViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = ObservedObject(wrappedValue: IntervalListViewModel(router: router))
    }
    
    var body: some View {
        Text("인터벌 리스트 페이지")
    }
}
