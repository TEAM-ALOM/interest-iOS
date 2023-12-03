////
////  WatchIntervalStateManageScreen.swift
////  WatchPresentation
////
////  Created by 민지은 on 2023/11/28.
////
//
//import Foundation
//import SwiftUI
//
//import WatchDomain
//import WatchShared
//import WatchSharedDesignSystem
//
//public struct WatchIntervalStateManageScreen: View {
//    @StateObject var viewModel: WatchIntervalStateViewModel
//
//    public init(viewModel: WatchIntervalStateViewModel) {
//        self._viewModel = .init(wrappedValue: viewModel)
//    }
//
//    public var body: some View {
//        VStack{
//            Spacer()
//            
//            HStack{
//                Text("달리기")
//                    .foregroundStyle(Color.keyColor)
//                Spacer()
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 20)
//
//            
//            Button(action: {
//                viewModel.addNewIntervalButton()
//            }) {
//                HStack{
//                    Image(systemName: "plus.circle")
//                    Text("새로운 운동")
//                        .font(.system(size: 16))
//                        .fontWeight(.medium)
//                }
//                .foregroundStyle(Color(red: 0, green: 1, blue: 0.64))
//            }
//            .frame(width: 98, height: 20)
//            .buttonStyle(.plain)
//            .padding(.bottom, 24)
//
//            HStack(spacing: 16){
//                stateButton(imageName: "pause.fill", color: Color(red: 1, green: 0.9, blue: 0), backgroundColor: Color(red: 1, green: 0.9, blue: 0).opacity(0.2), text: "일시 정지")
//                
//                stateButton(imageName: "xmark", color: Color.warningColor, backgroundColor: Color.warningColor.opacity(0.2), text: "운동 종료")
//            }
//            
//            Spacer()
//            
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
//        .ignoresSafeArea()
//    }
//    
//    @ViewBuilder
//    func stateButton(imageName: String,color: Color,backgroundColor: Color,text: String) -> some View {
//        
//        VStack{
//            Button(action: {
//                
//            }) {
//                Image(systemName: imageName)
//                    .resizable()
//                    .frame(width: 20, height: 25)
//                    .foregroundStyle(color)
//            }
//            .frame(width: 72, height: 52)
//            .buttonStyle(.plain)
//            .background(backgroundColor)
//            .cornerRadius(20)
//            
//            Text(text)
//                .font(.system(size: 12))
//                .fontWeight(.medium)
//                .foregroundColor(Color.textColor50)
//        }
//    }
//    
//    
//}
