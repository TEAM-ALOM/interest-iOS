//
//  WatchIntervalRestingScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

import WatchDomain
import WatchShared
import WatchSharedDesignSystem

public struct WatchIntervalRestingScreen: View {
    @StateObject var viewModel: WatchIntervalActiveViewModel
    
    @State private var restingTime: TimeInterval = 0
    @State private var timer: Timer?
    
    public init(viewModel: WatchIntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack{
            HStack{
                Image(systemName: "circle.hexagonpath.fill")
                    .foregroundColor(Color.restColor)
                Text("휴식중")
                    .foregroundColor(Color.restColor)
                Spacer()
            }
            .padding(.horizontal,12)
            
            HStack{
                HStack{
                    Text(formattedRestingTime)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 28))
                }
                
                Spacer()
                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text("버닝")
                            .foregroundStyle(Color.burningColor)
                        Text("까지")
                            .foregroundStyle(Color.textColor50)
                    }
                    .font(.system(size: 10))
                    
                    HStack{
                        Text("남음")
                            .foregroundStyle(Color.textColor50)
                            .font(.system(size: 10))
                        
                    }
                }
            }
            .frame(width: 161, height: 28)
            Spacer()
            WatchIntervalInfoActiveView()
        }
        .background{
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0.2), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
        }
        .onAppear(perform: {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.restingTime += 0.01
            }
        })
    }
    
    private var formattedRestingTime: String {
        let minutes = Int(restingTime / 60)
        let seconds = Int(restingTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((restingTime * 100).truncatingRemainder(dividingBy: 100))

        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}
