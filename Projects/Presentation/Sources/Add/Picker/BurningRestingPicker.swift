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
    public var isBurning: Bool
    
    @Binding public var heartType: HeartIntervalType
    
    @Binding public var totalTime: Int
    @State private var hours: Int
    @State private var minutes: Int
    @State private var seconds: Int
    
    @State private var wakeUp = Date()
    
    @State private var isTimeExpanded: Bool = false
    @State private var isSectionExpanded: Bool = false
    
    public init(isBurning: Bool, heartType: Binding<HeartIntervalType>, totalTime: Binding<Int>) {
        self.isBurning = isBurning
        _heartType = heartType
        _totalTime = totalTime
        
        let totalSeconds = totalTime.wrappedValue
        _hours = State(initialValue: totalSeconds / 3600)
        _minutes = State(initialValue: (totalSeconds % 3600) / 60 )
        _seconds = State(initialValue: totalSeconds % 60)
    }
    
    public var body: some View {
        containerView
            .onAppear(perform: calculateTime)
    }
}

private extension BurningRestingPicker {
    private var containerView: some View {
        VStack {
            HStack {
                Image(systemName: isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .foregroundStyle(isBurning ? Color.burningColor : Color.restColor)
                
                Text(isBurning ? "버닝 옵션" : "휴식 옵션")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor)
                
                Spacer()
            }
            .padding(.bottom, 12)
            
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
    }
    
    @ViewBuilder
    private func pickTimeView(hour:Binding<Int>,minute:Binding<Int>,second:Binding<Int>, isExpanded: Binding<Bool>) -> some View {
        
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.wrappedValue.toggle()
                }
            }, label: {
                HStack{
                    Text("시간")
                        .foregroundStyle(Color.textColor)
                    
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
            }
            
            if (isExpanded.wrappedValue) {
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func timePicker(hour:Binding<Int>,minute:Binding<Int>,second:Binding<Int>) -> some View {
        GeometryReader { geometry in
            HStack(){
                Picker("시간", selection: $hours) {
                    ForEach(0..<12) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                            .foregroundStyle(Color.textColor)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("시간")
                    .foregroundStyle(Color.textColor)
                
                Picker("분", selection: $minutes) {
                    ForEach(0..<60) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                            .foregroundStyle(Color.textColor)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/4.5)
                
                Text("분")
                    .foregroundStyle(Color.textColor)
                
                Picker("초", selection: $seconds) {
                    ForEach(0..<60) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                            .foregroundStyle(Color.textColor)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/4.5)
                
                Text("초")
                    .foregroundStyle(Color.textColor)
            }
        }
    }
    
    @ViewBuilder
    private func pickIntervalView(selection: Binding<HeartIntervalType>, isExpanded: Binding<Bool>) -> some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.wrappedValue.toggle()
                }
            }, label: {
                HStack{
                    Text("구간")
                        .foregroundStyle(Color.textColor)
                    
                    Spacer()
                    Text("\(selection.wrappedValue.heartTypeName)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            })
            
            Divider()
            
            if(isSectionExpanded){
                Picker("", selection: selection) {
                    ForEach(HeartIntervalType.allCases, id: \.self) { type in
                        Text(type.title).tag(type)
                            .foregroundStyle(Color.textColor)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: isExpanded.wrappedValue ? 213 : 0)
                .offset(y: -7)
                
            }
        }
        if (isExpanded.wrappedValue) {
            Divider()
        }
    }
    
    private func calculateTime() {
        totalTime = hours * 3600 + minutes * 60 + seconds
    }
}

private extension HeartIntervalType {
    var title: String {
        switch self {
        case .one: "1구간 (123~134BPM)"
        case .two: "2구간 (135~148BPM)"
        case .three: "3구간 (149~162BPM)"
        case .four: "4구간 (163~175BPM)"
        case .five: "5구간 (176BPM~)"
        }
    }
}
