//
//  AddIntervalScreen.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SharedDesignSystem
import Domain

public struct AddIntervalScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var isTapped: Bool = false

    @StateObject var viewModel: AddIntervalViewModel
    
    
    public init(viewModel: AddIntervalViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack{
            VStack{
                name
                exercise
                repeatCount
                burningResting
                Spacer()
            }
            .padding(.horizontal,30)
            .backgroundStyle(Color.clear)
            .ignoresSafeArea()
            .navigationTitle("인터벌 추가")
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
                        viewModel.tapSaveButton(at: UUID())
                        dismiss()
                    }, label: {
                        Text("저장")
                    })
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
    private var name: some View {
        VStack{
            HStack{
                Text("이름")
                    .fontWeight(.semibold)
                Spacer()
            }
            TextField("달리기 인터벌", text: $viewModel.name)
                .padding(.all,12)
                .background(colorScheme == .dark ? Color.textColor25 : Color.textColor75)
                .cornerRadius(10)

        }
        .padding(.top,80)
    }
    private var exercise: some View {
          HStack{
              ExercisePicker(exerciseImage: $viewModel.exercise, selectedExerciseId: $viewModel.selectedExerciseId)
          }
      }
    
    private var repeatCount: some View {
        VStack{
            RepeatPicker(isRepeat: false, repeatCount: $viewModel.repeatCounts)
        }
    }
    
    private var burningResting: some View {
        VStack{
            BurningRestingPicker(isBurning: true, time: $viewModel.burningTime, selection: $viewModel.burningSelectedInterval)
            
            BurningRestingPicker(isBurning: false, time: $viewModel.restTime, selection: $viewModel.restSelectedInterval)
            
        }
    }
}
struct ExercisePicker: View {
    @Binding var exerciseImage : [ExerciseImage]
    @Binding var selectedExerciseId: ExerciseImage.ID?
    
    var body: some View {
        pickExerciseView(exercise: $exerciseImage)
    }
    
    @ViewBuilder
    func pickExerciseView (exercise :Binding<[ExerciseImage]>) -> some View {
        HStack(spacing : 20){
            ForEach(exercise.wrappedValue, id: \.self) { exerciseImage in
                Button(action: {
                    self.selectedExerciseId = exerciseImage.id
                }, label: {
                    ZStack{
                        Circle()
                            .fill(self.selectedExerciseId == exerciseImage.id  ? Color.keyColor : Color.clear)
                            .frame(width: 40,height: 40)
                        
                        Image(systemName: "\(exerciseImage.rawValue)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 28)
                            .foregroundColor(Color.keyColor50)
                    }
                })
            }
        }
    }
}
