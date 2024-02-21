//
//  ExercisePicker.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import SwiftUI
import Domain

public struct ExercisePickerView: View {
    @Namespace var heroEffect
    
    @Binding var selectedExerciseType: ExerciseType
    
    public init(selectedExerciseType: Binding<ExerciseType>) {
        _selectedExerciseType = selectedExerciseType
    }

    public var body: some View {
        pickerView
    }
    
    private var pickerView: some View {
        HStack {
            ForEach(ExerciseType.allCases, id: \.self) { exerciseType in
                Button(action: {
                    withAnimation(.smooth) {
                        self.selectedExerciseType = exerciseType
                    }
                }, label: {
                    Image(systemName: exerciseType.systemImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.keyColor75)
                        .padding(8)
                        .background {
                            if (self.selectedExerciseType == exerciseType) {
                                Circle()
                                    .fill(Color.keyColor)
                                    .matchedGeometryEffect(id: "selected", in: heroEffect)
                            }
                        }
                })
                
                if (ExerciseType.allCases.last != exerciseType) {
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ExercisePickerView(selectedExerciseType: .constant(.run))
}
