//
//  ExercisePicker.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import SwiftUI
import Domain

struct ExercisePicker: View {
    @Binding var exerciseImage : [ExerciseTypeModel]
    @Binding var selectedExerciseId: ExerciseTypeModel.ID?
    
    var body: some View {
        pickExerciseView(exercise: $exerciseImage)
    }
    
    @ViewBuilder
    func pickExerciseView (exercise :Binding<[ExerciseTypeModel]>) -> some View {
        HStack(spacing : 30){
            ForEach(exercise.wrappedValue, id: \.self) { exerciseImage in
                Button(action: {
                    self.selectedExerciseId = exerciseImage.id
                }, label: {
                    ZStack{
                        Circle()
                            .fill(self.selectedExerciseId == exerciseImage.id  ? Color.keyColor : Color.clear)
                            .frame(width: 42,height: 42)
                        
                        Image(systemName: "\(exerciseImage.rawValue)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color.keyColor50)
                    }
                })
            }
        }
    }
}
