//
//  AddIntervalScreen.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct AddIntervalScreen: View {
    @StateObject var viewModel: AddIntervalViewModel
    
    @State private var isBurningTimer = false
    @State private var isBurningSection = false
    @State private var isRestingTimer = false
    @State private var isRestingSection = false
    
    private var selection = ["1구간 (120BPM~135BPM)", "2구간 (135~148BPM)", "3구간 (149~162BPM)", "4구간 (163~175BPM)", "5구간 (176BPM~)"]
    
    @State private var selectedSection = ""
    
    public init(viewModel: AddIntervalViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack{
            title
            name
            exercise
            reiteration
            burning
            resting
            Spacer()
        }
        .padding(.horizontal,30)
    }
    private var title: some View {
        HStack{
            Button(action:{}, label: {
                Text("취소")
                    .foregroundStyle(Color.keyColor75)
            })
            Spacer()
            Text("인터벌 추가")
            Spacer()
            
            Button(action:{}, label: {
                Text("저장")
                    .foregroundStyle(Color.keyColor75)
            })
        }
        .padding(.top,11)
    }
    private var name: some View {
        HStack{
            Text("이름")
                .padding(.top,40)
            Spacer()
        }
    }
    private var exercise: some View {
        HStack{
            Button(action: {}, label: {
                ZStack{
                    Circle()
                        .fill(Color.keyColor)
                        .frame(width: 40,height: 40)
                    
                    Image(systemName: "figure.run")
                        .resizable()
                        .frame(width: 21, height: 28)
                        .padding(.horizontal,20)
                }
            })
            
            Button(action: {}, label: {
                Image(systemName: "figure.outdoor.cycle")
                    .resizable()
                    .frame(width: 36, height: 28)
                    .padding(.horizontal,20)
            })
            
            Button(action: {}, label: {
                Image(systemName: "figure.pool.swim")
                    .resizable()
                    .frame(width: 45, height: 28)
                    .padding(.horizontal,20)
            })
            Button(action: {}, label: {
                Image(systemName: "figure.stair.stepper")
                    .resizable()
                    .frame(width: 19, height: 28)
                    .padding(.horizontal,20)
            })
            
            Button(action: {}, label: {
                Image(systemName: "figure.run")
                    .resizable()
                    .frame(width: 21, height: 28)
                    .padding(.horizontal,20)
            })
        }
        .foregroundStyle(Color.keyColor50)
        
    }
    private var reiteration: some View {
        HStack{
            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                .foregroundStyle(Color.keyColor)
            Text("반복 횟수")
            
            Spacer()
            
            Text("4회")
        }
        .padding(.top,25)
        
    }
    private var burning: some View {
        
        VStack{
            HStack{
                Image(systemName: "flame.fill")
                    .foregroundStyle(Color.burningColor)
                
                Text("버닝 옵션")
                Spacer()
            }
            .padding(.vertical,15)
            
            Button(action: {
                isBurningTimer.toggle()
                isBurningSection = false
                isRestingTimer = false
                isRestingSection = false
            }, label: {
                HStack{
                    Text("시간")
                    Spacer()
                    Text("00:04:30")
                }
                .padding(.vertical,10)
            })
       
            Divider()
            
            if(isBurningTimer){
                TimerPickerView()
            }
            Button(action: {
                isBurningTimer = false
                isBurningSection.toggle()
                isRestingTimer = false
                isRestingSection = false
            }, label: {
                HStack{
                    Text("구간")
                    Spacer()
                    Text("5구간")
                }
                .padding(.vertical,10)
            })

            if(isBurningSection){
                Picker("", selection: $selectedSection, content: {
                    ForEach(selection, id: \.self) {
                        Text($0)
                    }
                })
                .pickerStyle(.wheel)
            }
            
        }
    }
    private var resting: some View {
        VStack{
            HStack{
                Image(systemName: "circle.hexagonpath.fill")
                    .foregroundStyle(Color.restColor)
                
                Text("휴식 옵션")
                Spacer()
            }
            .padding(.vertical,15)
            
            Button(action: {
                isBurningTimer = false
                isBurningSection = false
                isRestingTimer.toggle()
                isRestingSection = false
            }, label: {
                HStack{
                    Text("시간")
                    Spacer()
                    Text("00:04:30")
                }
                .padding(.vertical,10)
            })
            Divider()
            
            if(isRestingTimer){
                TimerPickerView()
            }
            
            Button(action: {
                isBurningTimer = false
                isBurningSection = false
                isRestingTimer = false
                isRestingSection.toggle()
            }, label: {
                HStack{
                    Text("구간")
                    Spacer()
                    Text("5구간")
                }
                .padding(.vertical,10)
            })
            
            if(isRestingSection){
                Picker("Select Section", selection: $selectedSection, content: {
                    ForEach(selection, id: \.self) {
                        Text($0)
                    }
                })
                .pickerStyle(.wheel)
            }
        }
    }
    struct TimerPickerView: View {
        @State private var selectedHour: Int = 0
        @State private var selectedMinute: Int = 0
        @State private var selectedSecond: Int = 0
        
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 0) {
                        Spacer()
                        Picker("", selection: $selectedHour) {
                            ForEach(0..<24, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width/4, height: 200)
                        .clipped()
                        
                        Text("시간")
                        
                        Picker("", selection: $selectedMinute) {
                            ForEach(0..<60, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width/4, height: 200)
                        .clipped()
                        Text("분")
                        
                        
                        Picker("", selection: $selectedSecond) {
                            ForEach(0..<60, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width/4, height: 200)
                        .clipped()
                        Text("초")
                        Spacer()
                    }
                }
            }
        }
    }
    
}
