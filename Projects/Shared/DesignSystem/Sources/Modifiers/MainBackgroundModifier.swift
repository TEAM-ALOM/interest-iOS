//
//  BackgroundModifier.swift
//  SharedDesignSystem
//
//  Created by 김도형 on 12/30/23.
//

import Foundation
import SwiftUI

struct MainBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .background {
                    ZStack {
                        Color.backgroundColor
                        
                        switch colorScheme {
                        case .light:
                            LinearGradient.lightBackground
                        default:
                            LinearGradient.darkBackground
                        }
                    }
                    .ignoresSafeArea()
                }
            #if os(iOS)
                .toolbarBackground(Color.navigationColor, for: .navigationBar)
            #endif
        }
    }
}
