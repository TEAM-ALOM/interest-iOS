////
////  IntervalSelectScreen.swift
////  WatchPresentation
////
////  Created by 최유경 on 11/18/23.
////
//import Foundation
//import SwiftUI
//
//import WatchDomain
//import WatchShared
//import WatchSharedDesignSystem
//
//public struct WatchIntervalSelectScreen: View {
//    @StateObject var viewModel: WatchIntervalSelectViewModel
//    
//    public init(viewModel: WatchIntervalSelectViewModel) {
//        self._viewModel = .init(wrappedValue: viewModel)
//    }
//    
//    public var body: some View {
//        VStack{
//            HStack{
//                Text("인터레스트")
//                    .foregroundStyle(Color.keyColor)
//                    .padding(.horizontal,12)
//                Spacer()
//            }
//            Spacer()
//            
//            Button(action: {
//                viewModel.tapIntervalStartButton()
//            }) {
//                Image(systemName: "play.circle.fill")
//                    .resizable()
//                    .foregroundStyle(Color.keyColor)
//            }
//            .frame(width: 52, height: 52)
//            .buttonStyle(.plain)
//        }
//        .background {
//            LinearGradient(
//                stops: [
//                    Gradient.Stop(color: Color(red: 0.02, green: 0.7, blue: 1).opacity(0.2), location: 0.00),
//                    Gradient.Stop(color: Color(red: 0.02, green: 0.71, blue: 1).opacity(0), location: 1.00),
//                ],
//                startPoint: UnitPoint(x: 0.5, y: 0),
//                endPoint: UnitPoint(x: 0.5, y: 1)
//            )
//            .ignoresSafeArea()
//        }
//    }
//}
