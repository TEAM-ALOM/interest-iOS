//
//  IntervalActiveScreenWithiPhone.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalActiveIPhoneScreen: View {
    @State var viewModel: IntervalActiveViewModel
    
    public var body: some View {
        VStack{
            IntervalChangeView(viewModel: $viewModel)
            Spacer(minLength: 20)
            
            HealthInfoView(viewModel: $viewModel)
            Spacer(minLength: 20)
            
            StateManageView(viewModel: $viewModel)
            Spacer(minLength: 20)
        }
        .padding(.horizontal,16)
        .navigationTitle(viewModel.interval.title)
        .navigationBarTitleDisplayMode(.inline)
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
        .onAppear(perform: {
            viewModel.setupTimer()
        })
        
    }
}
