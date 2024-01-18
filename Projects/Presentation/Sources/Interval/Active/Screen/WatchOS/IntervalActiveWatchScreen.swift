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
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    @State private var isBounce = true
    @State private var timer: Timer?
    @State private var totalTime = 0.0
    
    public var body: some View {
        VStack(alignment: .center){
            IntervalChangedView(viewModel: viewModel, totalTime: $totalTime)
            
            Spacer()
            
            HealthInfoView(viewModel: viewModel, isBounce: $isBounce, totalTime: $totalTime)
        }
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
      
        .onAppear(perform: {
            totalTime = Double(viewModel.intervalItem.burningSecondTime)
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                viewModel.activeTime += 0.01
                isBounce.toggle()
                
                if(viewModel.activeTime == totalTime){
                    viewModel.currentCount += 1
                    viewModel.isBurning.toggle()
                    
                    totalTime += Double(viewModel.isBurning ?  viewModel.intervalItem.burningSecondTime : viewModel.intervalItem.restingSecondTime)
                }
            }
        })
    }
}
