//
//  WatchExercisePickerView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI
import Domain

struct WatchExercisePickerView: View {
    var viewModel: IntervalListViewModel

    @State private var currentIndex : Int = 0
    @GestureState private var dragOffset : CGFloat = 0
    
    var body: some View {
        VStack{
            if viewModel.intervals.count != 0 {
                NavigationStack{
                    ZStack {
                        //intervalitems을 가져와야함
                        ForEach(0..<viewModel.intervals.count, id: \.self) { index in
                            itemView(index)
                        }
                    }
                }
                .gesture(dragGesture)
                
                Text(viewModel.intervals[currentIndex].title)
                    .padding(.top,5)
            }
        }
    }
    
    private func itemView(_ index: Int) -> some View {
        Button(action: {
            withAnimation{
                currentIndex = index
                viewModel.selectedInterval = viewModel.intervals[currentIndex]
            }
        }, label: {
            ZStack {
                Circle()
                    .fill(currentIndex == index ? Color.white : Color.clear)
                    .frame(width: 52, height: 52)
                    .scaleEffect(currentIndex == index ? 1.0 : 0.7)
                
                Image(systemName: viewModel.intervals[currentIndex].exerciseType.systemImageName)
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
            viewModel.selectedInterval = viewModel.intervals[currentIndex]
        })
    }
    
    private var dragGesture: some Gesture {
        DragGesture().onEnded { value in
            let threshold: CGFloat = 50
            if value.translation.width > threshold {
                currentIndex = max(0, currentIndex - 1)
            }
            else if value.translation.width < -threshold {
                currentIndex = min(viewModel.intervals.count - 1, currentIndex + 1)
            }
        }
    }
}



