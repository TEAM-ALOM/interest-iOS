//
//  WatchSelectedView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import SwiftUI

struct WatchSelectedView: View {
    @ObservedObject var viewModel: IntervalListViewModel
    
    var body: some View {
        VStack{
            exercise
                .padding(.top,5)
            Spacer()
            HStack{
                Spacer()
                start
                Spacer()
            }
        }
    }
    
    private var exercise: some View {
        WatchExercisePickerView()
            .onAppear() {
                viewModel.fetchIntervalItems()
            }
    }
    
    private var start: some View {
        Button(action: {
            // TODO: 실제 인터벌을 고르고 startButton을 누르는것으로 변경해야함
            viewModel.tapStartButton()
            //viewModel.tapIntervalStartButton(item: .init(title: "테스트 인터벌"))
        }) {
            Image(systemName: "play.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.keyColor)
        }
        .frame(width: 52,height: 52)
        .buttonStyle(.plain)
    }
}
