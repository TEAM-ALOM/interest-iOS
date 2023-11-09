//
//  EditIntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct EditIntervalScreen: View {
    @ObservedObject var viewModel: EditIntervalViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = ObservedObject(wrappedValue: EditIntervalViewModel(router: router))
    }
    
    var body: some View {
        Text("인터벌 수정 페이지")
    }
    
    
}
