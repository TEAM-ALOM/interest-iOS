//
//  AddPicker.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation
import SwiftUI
import Domain
import SharedDesignSystem

public struct BurningRestingPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    public var isBurning: Bool
    
    @Binding public var heartType : HeartIntervalType
        
    @Binding public var totalTime : Int
    @State private var hours : Int = 0
    @State private var minutes : Int = 0
    @State private var seconds : Int = 0

    @State private var isTimeExpanded: Bool = false
    @State private var isSectionExpanded: Bool = false
    
    public init(isBurning: Bool, heartType: Binding<HeartIntervalType>, totalTime: Binding<Int>) {
        self.isBurning = isBurning
        _heartType = heartType
        _totalTime = totalTime
    }
    
    public var body: some View {
        VStack() {
            HStack {
                Image(systemName: isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .foregroundStyle(isBurning ? Color.burningColor : Color.restColor)
                
                Text(isBurning ? "버닝 옵션" : "휴식 옵션")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.vertical,15)
            
            pickTimeView(hour: $hours, minute: $minutes, second: $seconds, isExpanded: $isTimeExpanded)
                .onChange(of: hours) {
                    calculateTime()
                }
                .onChange(of: minutes) {
                    calculateTime()
                }
                .onChange(of: seconds) {
                    calculateTime()
                }
            
            pickIntervalView(selection: $heartType, isExpanded: $isSectionExpanded)
        }
        .onAppear(perform: calculateTime)
    }
    
    @ViewBuilder
    func pickTimeView (hour:Binding<Int>,minute:Binding<Int>,second:Binding<Int>, isExpanded: Binding<Bool>) -> some View {
        
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.wrappedValue.toggle()
                }
            }, label: {
                HStack{
                    Text("시간")
                        .foregroundStyle(Color(colorScheme == .dark ? .white: .black))
                    
                    Spacer()
                    
                    Text(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            })
            
            Divider()
            
            if (isTimeExpanded){
                timePicker(hour: $hours, minute: $minutes, second: $seconds)
                    .frame(height: isExpanded.wrappedValue ? 213 : 0)
                    .offset(y: -7)
            }
            
            if (isExpanded.wrappedValue) {
                Divider()
                    .padding(.bottom, 4)
            }
        }
    }
    
    private func calculateTime() {
        totalTime = hours * 3600 + minutes * 60 + seconds
    }
    
    @ViewBuilder
    func timePicker(hour:Binding<Int>,minute:Binding<Int>,second:Binding<Int>) -> some View {
        GeometryReader { geometry in
            HStack(){
                Picker("시간", selection: $hours) {
                    ForEach(0..<12) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("시간")
                
                Picker("분", selection: $minutes) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/4.5)
                Text("분")
                
                Picker("초", selection: $seconds) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/4.5)
                
                Text("초")
            }
        }
    }
    
    @ViewBuilder
    func pickIntervalView (selection: Binding<HeartIntervalType>, isExpanded: Binding<Bool>) -> some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.wrappedValue.toggle()
                }
            }, label: {
                HStack{
                    Text("구간")
                        .foregroundStyle(Color(colorScheme == .dark ? .white: .black))
                    
                    Spacer()
                    Text("\(selection.wrappedValue.heartTypeName)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
                .padding(.vertical,10)
            })
            
            Divider()
            
            if(isSectionExpanded){
                Picker("", selection: selection) {
                    Text("1구간 (123~134BPM)").tag(HeartIntervalType.one)
                    Text("2구간 (135~148BPM)").tag(HeartIntervalType.two)
                    Text("3구간 (149~162BPM)").tag(HeartIntervalType.three)
                    Text("4구간 (163~175BPM)").tag(HeartIntervalType.four)
                    Text("5구간 (176BPM~)").tag(HeartIntervalType.five)
                }
                .pickerStyle(.wheel)
                .frame(height: isExpanded.wrappedValue ? 213 : 0)
                .offset(y: -7)
            }
            if (isExpanded.wrappedValue) {
                Divider()
            }
            
        }
    }
}
