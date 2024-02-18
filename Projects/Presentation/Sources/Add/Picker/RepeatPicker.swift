//
//  RepeatPicker.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation
import SwiftUI
import Domain

public struct RepeatPicker: View {
    public var isRepeat: Bool
    
    @Binding public var repeatCount: Int
    
    @State private var isExpanded: Bool = false
    
    public init(isRepeat: Bool, repeatCount: Binding<Int>) {
        self.isRepeat = isRepeat
        _repeatCount = repeatCount
    }
    
    public var body: some View {
        VStack{
            pickRepeatView(count: $repeatCount, isExpanded: $isExpanded)
        }
    }
    
    @ViewBuilder
    private func pickRepeatView(count:Binding<Int>, isExpanded: Binding<Bool>) -> some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.wrappedValue.toggle()
                }
            }, label: {
                HStack{
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .foregroundStyle(Color.keyColor)
                    
                    Text("반복 횟수")
                        .fontWeight(.semibold)
                        //.foregroundStyle(Color(colorScheme == .dark ? .white: .black))
                    
                    Spacer()
                    
                    Text(String(format: "%d회",count.wrappedValue))
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
                .padding(.vertical,10)
            })
            
            Divider()
            
            repeatCountPicker(count: count)
                .frame(height: isExpanded.wrappedValue ? 213 : 0)
                .offset(y: -7)
            
            if (isExpanded.wrappedValue) {
                Divider()
                    .padding(.bottom, 4)
            }
        }
    }
    
    @ViewBuilder
    private func repeatCountPicker(count:Binding<Int>) -> some View {
        GeometryReader { geometry in
            Picker("", selection: count, content: {
                ForEach(0..<21) { i in
                    Text(String(format: "%2d", i))
                        .tag(i)
                }
            })
            .pickerStyle(.wheel)
        }
    }
}
