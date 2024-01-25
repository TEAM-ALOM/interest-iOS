//
//  ExercisePicker.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import SwiftUI

struct ExercisePickerView: View {
    @Binding var selectedExerciseType: ExerciseTypeModel
    
    var body: some View {
        pickerView
    }
    
    var pickerView: some View {
        HStack(spacing: 30) {
            ForEach(ExerciseTypeModel.allCases, id: \.self) { exerciseType in
                Button(action: {
                    self.selectedExerciseType = exerciseType
                }, label: {
                    ZStack{
                        Circle()
                            .fill(self.selectedExerciseType == exerciseType  ? Color.keyColor : Color.clear)
                            .frame(width: 42,height: 42)
                        
                        Image(systemName: exerciseType.systemImageName)
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
