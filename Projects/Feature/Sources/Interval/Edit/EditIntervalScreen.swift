//
//  EditIntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI
import Domain
import Presentation

public struct EditIntervalScreen: View {
    @State var viewModel: EditIntervalViewModel
    
    public init(viewModel: EditIntervalViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack{
            containerView
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .navigationTitle(
                    "인터벌 편집"
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

private extension EditIntervalScreen {
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
            TextField("달리기 인터벌", text: $viewModel.interval.title)
                .padding(.all,12)
                .cornerRadius(10)
        }
    }
    
    private var exercisePickerView: some View {
        HStack{
            ExercisePickerView(selectedExerciseType: $viewModel.interval.exerciseType)
        }
        .padding(.vertical,10)
    }
    
    private var repeatCountPickerView: some View {
        VStack{
            RepeatPicker(isRepeat: false, repeatCount: $viewModel.interval.repeatCount)
        }
    }
    
    private var burningRestingPickerView: some View {
        VStack{
            BurningRestingPicker(isBurning: true, heartType: $viewModel.interval.burningHeartIntervalType, totalTime: $viewModel.interval.burningSecondTime)
            
            BurningRestingPicker(isBurning: false, heartType: $viewModel.interval.restingHeartIntervalType, totalTime: $viewModel.interval.restingSecondTime)
        }
    }
}
