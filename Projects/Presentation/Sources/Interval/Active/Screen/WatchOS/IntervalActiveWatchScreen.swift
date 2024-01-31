//
//  IntervalActiveScreenWithWatchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalActiveWatchScreen: View {
    @State var viewModel: IntervalActiveViewModel
    
    @State private var isBounce = true
    @State private var timer: Timer?
    
    public var body: some View {
        VStack(alignment: .center){
            WatchIntervalChangeView(viewModel: $viewModel)
            
            Spacer()
            
            WatchHealthInfoView(viewModel: $viewModel)
        }
        .padding(.vertical , 5)
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
        .onAppear(perform: {
            viewModel.setupTimer()
        })
    }
}
