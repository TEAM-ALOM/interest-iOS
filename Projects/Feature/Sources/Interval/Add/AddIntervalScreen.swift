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
                        .disabled(viewModel.interval.title == "")
                    }
                }
        }
    }
}

private extension AddIntervalScreen {
    private var containerView: some View {
        ScrollView {
            VStack(spacing: 20) {
                nameView
                exercisePickerView
                repeatCountPickerView
                burningRestingPickerView
                Spacer()
            }
            .padding(.top, 28)
            .padding(.horizontal, 24)
        }
        .mainBackground()
    }
    
    private var nameView: some View {
        VStack(spacing: 12) {
            HStack{
                Text("이름")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor)
                Spacer()
            }
            
            TextField("인터벌 이름", text: $viewModel.interval.title)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .fill(Color.textColor25)
                        .shadow(color: .black.opacity(0.05), radius: 5)
                }
        }
    }
    private var exercisePickerView: some View {
        ExercisePickerView(
            selectedExerciseType: $viewModel.interval.exerciseType
        )
    }
    
    private var repeatCountPickerView: some View {
        RepeatPicker(
            isRepeat: false,
            repeatCount: $viewModel.interval.repeatCount
        )
    }
    
    private var burningRestingPickerView: some View {
        Group {
            BurningRestingPicker(
                isBurning: true,
                heartType: $viewModel.interval.burningHeartIntervalType,
                totalTime: $viewModel.interval.burningSecondTime
            )
            
            BurningRestingPicker(
                isBurning: false,
                heartType: $viewModel.interval.restingHeartIntervalType,
                totalTime: $viewModel.interval.restingSecondTime
            )
        }
    }
}

#Preview {
    AddIntervalScreen(viewModel: .init())
}
