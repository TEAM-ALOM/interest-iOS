//
//  IntervalDetailScreen.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

struct IntervalDetailScreen: View {
    @StateObject private var viewModel: IntervalDetailViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = StateObject(wrappedValue: IntervalDetailViewModel(router: router))
    }
    
    var body: some View {
        Text("인터벌 상세와 시작하기 페이지")
    }
}

#Preview {
    NavigationStack {
        IntervalDetailScreen(router: IntervalRouter())
            .navigationTitle("인터벌 이름")
            .navigationBarTitleDisplayMode(.inline)
    }
}
