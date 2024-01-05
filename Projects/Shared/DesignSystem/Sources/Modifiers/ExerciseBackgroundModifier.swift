//
//  BurningBackground.swift
//  SharedDesignSystem
//
//  Created by 김도형 on 12/30/23.
//

import Foundation
import SwiftUI

struct ExerciseBackgroundModifier: ViewModifier {
    init(mode: ExerciseMode) {
        self.mode = mode
    }
    
    private let mode: ExerciseMode
    
    func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    Color(red: 0.12, green: 0.12, blue: 0.12)
                    
                    switch mode {
                    case .burning:
                        LinearGradient.burningBackground
                    case .rest:
                        LinearGradient.restBackground
                    }
                }
                .ignoresSafeArea()
            }
    }
}

extension ExerciseBackgroundModifier {
    enum ExerciseMode {
        case burning
        case rest
    }
}
