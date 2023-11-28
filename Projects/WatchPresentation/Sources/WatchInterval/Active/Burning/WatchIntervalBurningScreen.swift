//
//  WatchIntervalBurningScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

import WatchDomain
import WatchShared
import WatchSharedDesignSystem


public struct WatchIntervalBurningScreen: View {
    @StateObject var viewModel: WatchIntervalActiveViewModel
    
    public init(viewModel: WatchIntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    @State private var timer: Timer?
    
    public var body: some View {
            VStack(alignment: .center){
                HStack{
                    Image(systemName: "flame.fill")
                        .foregroundColor(Color.burningColor)
                    Text("버닝중")
                        .foregroundColor(Color.burningColor)
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
                            Text("휴식")
                                .foregroundStyle(Color.restColor)
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
                        Gradient.Stop(color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0.2), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .ignoresSafeArea()
            }
            .onAppear(perform: {
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
//                    self.burningTime += 0.01
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
