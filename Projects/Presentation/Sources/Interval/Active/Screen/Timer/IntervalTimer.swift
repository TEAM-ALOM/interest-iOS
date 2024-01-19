//
//  File.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI

public struct IntervalTimer {
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    @State private var untilResting : TimeInterval = 0
    @State private var untilBurning : TimeInterval = 0
    
    public var calculateUntilTime : String {
        var time = 0.0
        
        if(viewModel.isBurning){
            untilResting = viewModel.totalTime - viewModel.activeTime
            time = untilResting
        }
        else{
            untilBurning = viewModel.totalTime - viewModel.activeTime
            time = untilBurning
        }
        
        let minutes = time / 60
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        
    }
    
    public var calculateActiveTime: String {
        let hours = Int(viewModel.activeTime / 3600)
        let minutes = Int(viewModel.activeTime / 60)
        let seconds = Int(viewModel.activeTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((viewModel.activeTime * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }
}
