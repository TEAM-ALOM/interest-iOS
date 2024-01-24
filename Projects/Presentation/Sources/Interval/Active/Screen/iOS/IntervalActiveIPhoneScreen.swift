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
        VStack(){
            IntervalChangeView(viewModel: $viewModel)
                .padding(.bottom,30)
            
            
            HealthInfoView(viewModel: $viewModel)
                .padding(.bottom,30)
            
            StateManageView(viewModel: $viewModel)
            
            Spacer()
        }
        .padding(.horizontal,16)
        .navigationTitle(viewModel.intervalItem.title)
        .navigationBarTitleDisplayMode(.inline)
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
        .onAppear(perform: {
            viewModel.totalTime =  Double(viewModel.intervalItem.burningSecondTime)
            viewModel.setupTimer()
        })
        
    }
}
