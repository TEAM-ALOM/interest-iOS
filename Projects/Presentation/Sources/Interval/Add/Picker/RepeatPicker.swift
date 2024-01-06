//
//  RepeatPicker.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation
import SwiftUI
import Domain

struct RepeatPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var isRepeat: Bool
    
    @Binding var repeatCount : RepeatCount
    
    @State private var isExpanded: Bool = false

    
    var body: some View {
        VStack{
            pickRepeatView(count: $repeatCount, isExpanded: $isExpanded)
        }
    }
    
    @ViewBuilder
    func pickRepeatView (count:Binding<RepeatCount>, isExpanded: Binding<Bool>) -> some View {
    
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
                        .foregroundStyle(Color(colorScheme == .dark ? .white: .black))

                    Spacer()
                    
                    Text(String(format: "%d회",count.wrappedValue.counts))
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
    func repeatCountPicker (count:Binding<RepeatCount>) -> some View {
        GeometryReader { geometry in
            Picker("", selection: count.counts, content: {
                ForEach(0..<20) { i in
                    Text(String(format: "%2d", i))
                        .tag(i)
                }
            })
            .pickerStyle(.wheel)
        }
    }
}
