//
//  ExercisePicker.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import SwiftUI

import Domain

struct ExercisePickerView: View {
    @Binding var selectedExerciseType: ExerciseType
    
    var body: some View {
        pickerView
    }
    
    var pickerView: some View {
        HStack(spacing: 30) {
            ForEach(ExerciseType.allCases, id: \.self) { exerciseType in
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
