//
//  AddIntervalScreen.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SwiftData
import SharedDesignSystem
import Domain
import Presentation

public struct AddIntervalScreen: View {
    @State var viewModel: AddIntervalViewModel
    
    public init(viewModel: AddIntervalViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            containerView
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .navigationTitle(
                    "인터벌 추가"
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            viewModel.tapCancelButton()
                        }, label: {
                            Text("취소")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.tapSaveButton()
                        }, label: {
                            Text("저장")
                        })
                    }
                }
        }
    }
}

private extension AddIntervalScreen {
    private var containerView: some View {
        ScrollView {
            nameView
            exercisePickerView
            repeatCountPickerView
            burningRestingPickerView
            Spacer()
        }
    }
    
    private var nameView: some View {
        VStack{
            HStack{
                Text("이름")
                    .fontWeight(.semibold)
                Spacer()
            }
            TextField("달리기 인터벌", text: $viewModel.intervalEntity.title)
                .padding(.all, 12)
                .cornerRadius(10)
            
        }
    }
    private var exercisePickerView: some View {
        HStack{
            ExercisePickerView(
                selectedExerciseType: $viewModel.intervalEntity.exerciseType
            )
        }
        .padding(.vertical, 10)
    }
    
    private var repeatCountPickerView: some View {
        VStack{
            RepeatPicker(
                isRepeat: false,
                repeatCount: $viewModel.intervalEntity.repeatCount
            )
        }
    }
    
    private var burningRestingPickerView: some View {
        VStack{
            BurningRestingPicker(
                isBurning: true,
                heartType: $viewModel.intervalEntity.burningHeartIntervalType,
                totalTime: $viewModel.intervalEntity.burningSecondTime
            )
            
            BurningRestingPicker(
                isBurning: false,
                heartType: $viewModel.intervalEntity.restingHeartIntervalType,
                totalTime: $viewModel.intervalEntity.restingSecondTime
            )
        }
    }
}
