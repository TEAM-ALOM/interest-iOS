//
//  EditIntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct EditIntervalScreen: View {
    @StateObject var viewModel: EditIntervalViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        Text("인터벌 수정 페이지")
    }
    
    
}
