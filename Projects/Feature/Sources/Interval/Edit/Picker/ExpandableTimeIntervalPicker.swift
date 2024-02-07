//
//  ExpandableTimeIntervalPicker.swift
//  Presentation
//
//  Created by chaebeen on 11/26/23.
//

import SwiftUI
import Domain

struct expandableTimeIntervalPicker: View {
    var isBurning: Bool
    
    @Binding var selection: HeartIntervalTypeModel

    @State private var isExpanded1: Bool = false
    @State private var isExpanded2: Bool = false
    
    @State private var hours : Int = 0
    @State private var minutes : Int = 0
    @State private var seconds : Int = 0
    @Binding var totalTime : Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 7) {
                Image(systemName: isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(isBurning ? Color.burningColor : Color.restColor)
                
                Text(isBurning ? "버닝 옵션" : "휴식 옵션")
                    .font(.system(size: 16))
            }
            
            pickTimeView(hour: $hours, minute: $minutes, second: $seconds, isExpanded: $isExpanded1)
                .onAppear(perform: calculateTime)

            pickIntervalView(selection: $selection, isExpanded: $isExpanded2)
        }
    }
    
    @ViewBuilder
    func pickTimeView (hour:Binding<Int>,minute:Binding<Int>,second:Binding<Int>, isExpanded: Binding<Bool>) -> some View {

        VStack {
            HStack {
                Text("시간")
                    .font(.system(size: 15))
                    .bold()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.wrappedValue.toggle()
                    }
                }) {
                    Text(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            }
            
            Divider()
            
            timePicker(hour: $hours, minute: $minutes, second: $seconds)
                .frame(height: isExpanded.wrappedValue ? 213 : 0)
                .offset(y: -7)
            
            if (isExpanded.wrappedValue) {
                Divider()
                    .padding(.bottom, 4)
            }
        }
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
                .frame(width: geometry.size.width / 3)
                
                Picker("분", selection: $minutes) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3)
                
                Picker("초", selection: $seconds) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3)
            }
        }
    }
    private func calculateTime() {
        totalTime = hours * 3600 + minutes * 60 + seconds
    }
    
    @ViewBuilder
    func pickIntervalView (selection: Binding<HeartIntervalTypeModel>, isExpanded: Binding<Bool>) -> some View {
        VStack {
            HStack {
                Text("구간")
                    .font(.system(size: 15))
                    .bold()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.wrappedValue.toggle()
                    }
                }) {
                    Text("\(selection.wrappedValue.rawValue)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            }
            
            Divider()
            
            Picker("Interval", selection: selection) {
                Text("1구간 (123~134BPM)").tag(HeartIntervalTypeModel.one)
                Text("2구간 (135~148BPM)").tag(HeartIntervalTypeModel.two)
                Text("3구간 (149~162BPM)").tag(HeartIntervalTypeModel.three)
                Text("4구간 (163~175BPM)").tag(HeartIntervalTypeModel.four)
                Text("5구간 (176BPM~)").tag(HeartIntervalTypeModel.five)
            }
            .pickerStyle(.wheel)
            .frame(height: isExpanded.wrappedValue ? 213 : 0, alignment: .top)
            
            if (isExpanded.wrappedValue) {
                Divider()
            }
            
        }
    }
}
