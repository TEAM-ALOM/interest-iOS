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
    
    public var body: some View {
        VStack(alignment: .center){
            WatchIntervalChangeView(viewModel: viewModel)
            
            Spacer()
            
            WatchHealthInfoView(viewModel: viewModel, isBounce: $isBounce)
        }
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
      
        .onAppear(perform: {
            if(viewModel.isTimePass){
                $viewModel.totalTime.wrappedValue = Double(viewModel.intervalItem.burningSecondTime)
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: viewModel.isTimePass) { _ in
                    viewModel.activeTime += 0.01
                    isBounce.toggle()
                    
                    if(viewModel.activeTime == $viewModel.totalTime.wrappedValue){
                        viewModel.currentCount += 1
                        viewModel.isBurning.toggle()
                        
                        $viewModel.totalTime.wrappedValue += Double(viewModel.isBurning ?  viewModel.intervalItem.burningSecondTime : viewModel.intervalItem.restingSecondTime)
                    }
                }
            }
        })
    }
}
