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
    
    private var name: some View {
        VStack{
            HStack{
                Text("이름")
                    .fontWeight(.semibold)
                Spacer()
            }
            TextField("달리기 인터벌", text: $viewModel.intervalEntity.title)
                .padding(.all,12)
                //.background(colorScheme == .dark ? Color.textColor25 : Color.textColor75)
                .cornerRadius(10)
            
        }
    }
    private var exercise: some View {
        HStack{
            ExercisePickerView(selectedExerciseType: $viewModel.intervalEntity.exerciseType)
        }
        .padding(.vertical,10)
    }
    
    private var repeatCount: some View {
        VStack{
            RepeatPicker(isRepeat: false, repeatCount: $viewModel.intervalEntity.repeatCount)
        }
    }
    
    private var burningResting: some View {
        VStack{
            BurningRestingPicker(isBurning: true, heartType: $viewModel.intervalEntity.burningHeartIntervalType, totalTime: $viewModel.intervalEntity.burningSecondTime)
            
            BurningRestingPicker(isBurning: false, heartType: $viewModel.intervalEntity.restingHeartIntervalType, totalTime: $viewModel.intervalEntity.restingSecondTime)
        }
    }
}
