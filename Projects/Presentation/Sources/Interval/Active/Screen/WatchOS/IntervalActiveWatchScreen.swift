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
            viewModel.totalTime =  Double(viewModel.intervalItem.burningSecondTime)
        })
        .onReceive(
            viewModel.$isTimePass, perform: { isTimePassing in
                if isTimePassing {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                        viewModel.activeTime += 0.01
                        isBounce.toggle()
                        
                        if(viewModel.activeTime == viewModel.totalTime){
                            if(viewModel.isBurning){
                                viewModel.currentCount += 1
                            }
                            viewModel.isBurning.toggle()
                            
                            viewModel.totalTime += Double(viewModel.isBurning ?  viewModel.intervalItem.burningSecondTime : viewModel.intervalItem.restingSecondTime)
                        }
                    }
                }
                else {
                    timer?.invalidate()
                    timer = nil
                }
            })
    }
}
