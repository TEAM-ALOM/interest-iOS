//
//  WatchExercisePickerView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI

struct WatchExercisePickerView: View {
    var viewModel: IntervalListViewModel

    @State private var currentIndex : Int = 0
    @GestureState private var dragOffset : CGFloat = 0
    
    var body: some View {
        VStack{
            NavigationStack{
                ZStack {
                    //intervalitems을 가져와야함
                    ForEach(0..<IntervalModel.mocks.count, id: \.self) { index in
                        itemView(index)
                    }
                }
            }
            .gesture(dragGesture)
            
            Text(IntervalModel.mocks[currentIndex].title)
                .padding(.top,5)
            
        }
    }
    
    private func itemView(_ index: Int) -> some View {
        Button(action: {
            withAnimation{
                currentIndex = index
                viewModel.selectedItem = IntervalModel.mocks[currentIndex]
            }
        }, label: {
            ZStack {
                Circle()
                    .fill(currentIndex == index ? Color.white : Color.clear)
                    .frame(width: 52, height: 52)
                    .scaleEffect(currentIndex == index ? 1.0 : 0.7)
                
                Image(systemName: IntervalModel.mocks[index].exerciseType.systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(currentIndex == index ? Color.keyColor : Color.white)
                    .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                    .offset(x: CGFloat(index - currentIndex) * 60 + dragOffset , y : 0)
            }
        })
        .buttonStyle(.plain)
        .onAppear(perform: {
            viewModel.selectedItem = IntervalModel.mocks[currentIndex]
        })
    }
    
    private var dragGesture: some Gesture {
        DragGesture().onEnded { value in
            let threshold: CGFloat = 50
            if value.translation.width > threshold {
                currentIndex = max(0, currentIndex - 1)
            }
            else if value.translation.width < -threshold {
                currentIndex = min(IntervalModel.mocks.count - 1, currentIndex + 1)
            }
        }
    }
}



