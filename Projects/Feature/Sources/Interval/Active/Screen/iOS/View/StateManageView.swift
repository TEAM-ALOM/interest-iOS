//
//  StateManageView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI
import SharedDesignSystem

struct StateManageView: View {
    @Binding var viewModel: IntervalActiveViewModel
    
    var body: some View {
        HStack{
            Spacer()
            Text(viewModel.calculateActiveTime())
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 52, design: .rounded))
                .frame(width: 312, height: 52 , alignment: .leading)
            
            Spacer()
        }
    }
}

#Preview {
    IntervalActiveIPhoneScreen(viewModel: .init(interval: .init(id: .init())))
}
