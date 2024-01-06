//
//  AddPicker.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation
import SwiftUI
import Domain

struct BurningRestingPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var isBurning: Bool
    
    @Binding var time: Time
    @Binding var selection: HeartSection
    
    @State private var isTimeExpanded: Bool = false
    @State private var isSectionExpanded: Bool = false
    
    
    var body: some View {
        VStack() {
            HStack {
                Image(systemName: isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .foregroundStyle(isBurning ? Color.burningColor : Color.restColor)
                
                Text(isBurning ? "버닝 옵션" : "휴식 옵션")
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.vertical,15)
            
            pickTimeView(time: $time, isExpanded: $isTimeExpanded)
            
            pickIntervalView(selection: $selection, isExpanded: $isSectionExpanded)
        }
    }
    
    @ViewBuilder
    func pickTimeView (time:Binding<Time>, isExpanded: Binding<Bool>) -> some View {
        
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
                    
                    Text(String(format: "%02d:%02d:%02d", time.wrappedValue.hours, time.wrappedValue.minutes, time.wrappedValue.seconds))
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
            })
            
            Divider()
            
            if (isTimeExpanded){
                timePicker(time: time)
            }
            
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
                .frame(width: geometry.size.width/4.5)
                
                Text("시간")
                
                Picker("분", selection: time.minutes) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width/4.5)
                Text("분")
                
                Picker("초", selection: time.seconds) {
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
    func pickIntervalView (selection: Binding<HeartSection>, isExpanded: Binding<Bool>) -> some View {
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
                    Text("\(selection.wrappedValue.rawValue)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.keyColor)
                        .bold()
                }
                .padding(.vertical,10)
            })
            
            Divider()
            
            if(isSectionExpanded){
                Picker("", selection: selection) {
                    Text("1구간 (123~134BPM)").tag(HeartSection.section1)
                    Text("2구간 (135~148BPM)").tag(HeartSection.section2)
                    Text("3구간 (149~162BPM)").tag(HeartSection.section3)
                    Text("4구간 (163~175BPM)").tag(HeartSection.section4)
                    Text("5구간 (176BPM~)").tag(HeartSection.section5)
                }
                .pickerStyle(.wheel)
            }
            if (isExpanded.wrappedValue) {
                Divider()
            }
            
        }
    }
}
