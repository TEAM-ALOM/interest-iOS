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
    
    @State private var scrollOffset: CGFloat = .zero
    @State private var isScroll = false
    
    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .coordinateSpace(name: "CONTENT")
                .background {
                    let offset = reader.frame(in: .named("CONTENT")).minY
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                    
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
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                .onChange(of: scrollOffset) { oldValue, newValue in
                    withAnimation(.smooth) {
                        if (oldValue > newValue) {
                            isScroll = true
                        } else {
                            isScroll = false
                        }
                    }
                }
#if os(iOS)
                .overlay(alignment: .top) {
                    if isScroll {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(LinearGradient(colors: [.clear, .keyColor], startPoint: .bottom, endPoint: .center))
                            .frame(height: reader.safeAreaInsets.top + 52)
                            .ignoresSafeArea()
                    }
                }
#endif
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue = CGFloat.zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
