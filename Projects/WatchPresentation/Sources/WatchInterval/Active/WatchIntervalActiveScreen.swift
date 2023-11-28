//
//  WatchIntervalActiveScreen.swift
//  WatchPresentation
//
//  Created by 민지은 on 2023/11/28.
//
import Foundation
import SwiftUI

import WatchDomain
import WatchShared
import WatchSharedDesignSystem


public struct WatchIntervalActiveScreen: View {
    @StateObject var viewModel: WatchIntervalActiveViewModel
    
    public init(viewModel: WatchIntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    @State private var timer: Timer?

    public var body: some View {
            VStack(alignment: .center){
                HStack{
                    Image(systemName: viewModel.activeTime < 10 ? "flame.fill" : "circle.hexagonpath.fill")
                        .foregroundColor(viewModel.activeTime < 10 ? Color.burningColor : Color.restColor)
                    Text(viewModel.activeTime < 10 ? "버닝중" : "휴식중")
                        .foregroundColor(viewModel.activeTime < 10 ? Color.burningColor : Color.restColor)
                    Spacer()
                }
                .padding(.horizontal,12)
                
                HStack{
                    HStack{
                        Text(formattedBurningTime)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 28, design: .rounded))
                    }
                    
                    Spacer()
                    
                    VStack(alignment : .leading){
                        HStack(spacing:0){
                            Text(viewModel.activeTime < 10 ? "휴식" : "버닝")
                                .foregroundStyle(viewModel.activeTime < 10 ? Color.restColor : Color.burningColor)
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
                        Gradient.Stop(color: viewModel.activeTime < 10 ? Color(red: 1, green: 0.13, blue: 0.02).opacity(0.2) : Color(red: 0.09, green: 1, blue: 0.02).opacity(0.2), location: 0.00),
                        Gradient.Stop(color: viewModel.activeTime < 10 ? Color(red: 1, green: 0.13, blue: 0.02).opacity(0) : Color(red: 0.09, green: 1, blue: 0.02).opacity(0), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .ignoresSafeArea()
            }
            .onAppear(perform: {
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    viewModel.activeTime += 0.01
                }
                
            })
    }
    
    private var formattedBurningTime: String {
        let minutes = Int(viewModel.activeTime / 60)
        let seconds = Int(viewModel.activeTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((viewModel.activeTime * 100).truncatingRemainder(dividingBy: 100))

        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}
