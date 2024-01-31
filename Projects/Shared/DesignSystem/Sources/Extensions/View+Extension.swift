//
//  View+Extension.swift
//  SharedDesignSystem
//
//  Created by 김도형 on 12/30/23.
//

import Foundation
import SwiftUI

extension View {
    public func mainBackground() -> some View {
        modifier(MainBackgroundModifier())
    }
    
    public func exerciseBackground(mode: ExerciseBackgroundModifier.ExerciseMode) -> some View {
        modifier(ExerciseBackgroundModifier(mode: mode))
    }
}
