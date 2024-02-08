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
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var viewModel: AddIntervalViewModel
    @State var intervalEntity : IntervalEntity

    public init(viewModel: AddIntervalViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
        self._intervalEntity = .init(initialValue: IntervalEntity(id: UUID()))
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                name
                exercise
                repeatCount
                burningResting
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .navigationTitle(
                "인터벌 추가"
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("취소")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.tapSaveButton()
                        dismiss()
                    }, label: {
                        Text("저장")
                    })
                }
            }
        }
    }
    
    private var name: some View {
        VStack{
            HStack{
                Text("이름")
                    .fontWeight(.semibold)
                Spacer()
            }
            TextField("달리기 인터벌", text: viewModel.intervalItem.title)
                .padding(.all,12)
                .background(colorScheme == .dark ? Color.textColor25 : Color.textColor75)
                .cornerRadius(10)
            
        }
    }
    private var exercise: some View {
        HStack{
            ExercisePickerView(selectedExerciseType: $intervalEntity.exerciseType)
//            ExercisePickerView(selectedExerciseType: viewModel.intervalItem.exerciseType)
        }
        .padding(.vertical,10)
    }
    
    private var repeatCount: some View {
        VStack{
            RepeatPicker(isRepeat: false, repeatCount: $intervalEntity.repeatCount)
        }
    }
    
    private var burningResting: some View {
        VStack{
            BurningRestingPicker(isBurning: true, heartType: $intervalEntity.burningHeartIntervalType, totalTime: $intervalEntity.burningSecondTime)
            
            BurningRestingPicker(isBurning: false, heartType: $intervalEntity.restingHeartIntervalType, totalTime: $intervalEntity.restingSecondTime)
        }
    }
}
