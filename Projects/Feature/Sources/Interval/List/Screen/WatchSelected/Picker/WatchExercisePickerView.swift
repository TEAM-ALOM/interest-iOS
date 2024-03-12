//
//  WatchExercisePickerView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI
import Domain
import SharedDesignSystem

struct WatchExercisePickerView: View {
    var viewModel: IntervalListViewModel

    @GestureState private var dragOffset : CGFloat = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack{
            if viewModel.intervals.count != 0 {
                NavigationStack{
                    ZStack {
                        //intervalitems을 가져와야함
                        ForEach(viewModel.intervals) { interval in
                            itemView(interval)
                        }
                    }
                }
                .gesture(dragGesture)
                
                Text(viewModel.selectedInterval?.title ?? "")
                    .padding(.top,5)
            }
        }
    }
    
    @ViewBuilder
    private func itemView(_ interval: IntervalEntity) -> some View {
        let isSelected = viewModel.selectedInterval?.id == interval.id
        let index = viewModel.intervals.firstIndex { $0.id == interval.id } ?? 0
         
        Button(action: {
            withAnimation{
                currentIndex = index
                viewModel.selectedInterval = interval
            }
        }, label: {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.white : Color.clear)
                    .frame(width: 52, height: 52)
                    .scaleEffect(isSelected ? 1.0 : 0.7)
                
                Image(systemName:viewModel.selectedInterval?.exerciseType.systemImageName ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(isSelected ? Color.keyColor : Color.white)
                    .scaleEffect(isSelected ? 1.2 : 0.8)
                    .offset(x: CGFloat(index - currentIndex) * 60 + dragOffset , y : 0)
            }
        })
        .buttonStyle(.plain)
        .onAppear(perform: {
            viewModel.selectedInterval = viewModel.intervals.first { $0.id == interval.id }
        })
    }
    
    private var dragGesture: some Gesture {
        DragGesture().onEnded { value in
            let threshold: CGFloat = 50
            
            if value.translation.width > threshold {
                currentIndex = max(0, currentIndex - 1)
            } else if value.translation.width < -threshold {
                currentIndex = min(viewModel.intervals.count - 1, currentIndex + 1)
            }
        }
    }
}



