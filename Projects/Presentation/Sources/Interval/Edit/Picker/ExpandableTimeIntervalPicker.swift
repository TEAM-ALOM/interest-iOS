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
    
    @Binding var time: Time
    @Binding var selection: HeartSection
    
    @State private var isExpanded1: Bool = false
    @State private var isExpanded2: Bool = false
    
    
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
            
            pickTimeView(time: $time, isExpanded: $isExpanded1)
            
            pickIntervalView(selection: $selection, isExpanded: $isExpanded2)
        }
    }
    
    @ViewBuilder
    func pickTimeView (time:Binding<Time>, isExpanded: Binding<Bool>) -> some View {
    
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
                    Text(String(format: "%02d:%02d:%02d", time.wrappedValue.hours, time.wrappedValue.minutes, time.wrappedValue.seconds))
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            }
            
            Divider()
            
            timePicker(time: time)
                .frame(height: isExpanded.wrappedValue ? 213 : 0)
                .offset(y: -7)
            
            if (isExpanded.wrappedValue) {
                Divider()
                    .padding(.bottom, 4)
            }
        }
    }
    
    @ViewBuilder
    func timePicker (time:Binding<Time>) -> some View {
        GeometryReader { geometry in
            HStack(){
                Picker("시간", selection: time.hours) {
                    ForEach(0..<12) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3)
                
                Picker("분", selection: time.minutes) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3)
                
                Picker("초", selection: time.seconds) {
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
    
    @ViewBuilder
    func pickIntervalView (selection: Binding<HeartSection>, isExpanded: Binding<Bool>) -> some View {
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
                Text("1구간 (123~134BPM)").tag(HeartSection.section1)
                Text("2구간 (135~148BPM)").tag(HeartSection.section2)
                Text("3구간 (149~162BPM)").tag(HeartSection.section3)
                Text("4구간 (163~175BPM)").tag(HeartSection.section4)
                Text("5구간 (176BPM~)").tag(HeartSection.section5)
            }
            .pickerStyle(.wheel)
            .frame(height: isExpanded.wrappedValue ? 213 : 0, alignment: .top)
            
            if (isExpanded.wrappedValue) {
                Divider()
            }

        }
    }
}
