//
//  EditIntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

struct EditIntervalScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject var viewModel: EditIntervalViewModel
    
    @State private var burningSelectedInterval = Interval.interval1
    @State private var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @State private var restSelectedInterval = Interval.interval1
    @State private var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)

    
    @State private var name: String = ""
    
    public init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading) {
                    IntervalForm
                    
                    Spacer()
                }
                .backgroundStyle(Color.clear)
                .ignoresSafeArea()
                .navigationTitle("인터벌 편집")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("취소")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            //저장
                            dismiss()
                        }, label: {
                            Text("저장")
                        })
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var IntervalForm: some View {
        VStack (alignment: .leading) {
            Text("이름")
                .font(.system(size: 17))
            
            Text("달리기 인터벌")
                .frame(maxWidth: .infinity, minHeight: 40)
                .foregroundColor(Color.textColor50)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(colorScheme == .dark ? Color.textColor25 : Color.textColor75)

                }
                .padding(.bottom, 28)
            
            
            //버닝 픽커
            expandableTimeIntervalPicker(isBurning: true, time: $burningTime, selection: $burningSelectedInterval)
                .padding(.bottom, 25)
            
            
            //휴식 픽커
            expandableTimeIntervalPicker(isBurning: false, time: $restTime, selection: $restSelectedInterval)
        }
        .padding(.horizontal, 24)
    }
}

private struct expandableTimeIntervalPicker: View {
    var isBurning: Bool
    
    @Binding var time: Time
    @Binding var selection: Interval
    
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
            HStack{
                Picker("시간", selection: time.hours) {
                    ForEach(0..<12) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: (geometry.size.width) / 3)
                                
                Picker("분", selection: time.minutes) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: (geometry.size.width) / 3)
                
                Picker("초", selection: time.seconds) {
                    ForEach(0..<59) { i in
                        Text(String(format: "%2d", i))
                            .tag(i)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: (geometry.size.width) / 3)
            }
        }
    }
    
    @ViewBuilder
    func pickIntervalView (selection: Binding<Interval>, isExpanded: Binding<Bool>) -> some View {
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
                Text("1구간 (123~134BPM)").tag(Interval.interval1)
                Text("2구간 (135~148BPM)").tag(Interval.interval2)
                Text("3구간 (149~162BPM)").tag(Interval.interval3)
                Text("4구간 (163~175BPM)").tag(Interval.interval4)
                Text("5구간 (176BPM~)").tag(Interval.interval5)
            }
            .pickerStyle(.wheel)
            .frame(height: isExpanded.wrappedValue ? 213 : 0, alignment: .top)
            
            if (isExpanded.wrappedValue) {
                Divider()
            }

        }
    }
}

enum Interval: String, CaseIterable, Identifiable {
    case interval1 = "1구간"
    case interval2 = "2구간"
    case interval3 = "3구간"
    case interval4 = "4구간"
    case interval5 = "5구간"
    
    var id: Self { self }
}

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
}
