//
//  IntervalRecordCellView.swift
//  Presentation
//
//  Created by 김도형 on 12/31/23.
//

import SwiftUI
import SharedDesignSystem
import Domain

public struct IntervalRecordCellView: View {
    
    @State private var averageHeartRate: Double = 0
    @State private var calorie: Double = 0
    @State private var repeatedCount: Double = 0
    @State private var hour: Double = 0
    @State private var minute: Double = 0
    @State private var createDate: String = ""
    
    private let intervalRecordEntity: IntervalRecordEntity
    
    public init(intervalRecordEntity: IntervalRecordEntity) {
        self.intervalRecordEntity = intervalRecordEntity
    }
    
    public var body: some View {
        cell
    }
    
    private var cell: some View {
        VStack(spacing: 12) {
            calorieAndDate
            
            recordInfo
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .fill(Color.shapeColor)
                .shadow(color: .black.opacity(0.05), radius: 5)
        }
        .onAppear {
            withAnimation(.easeOut) {
                calculateAverageHeartRate()
                
                calculateCreateDate()
                
                calculateRecordInfo()
            }
        }
    }
    
    private var calorieAndDate: some View {
        HStack {
            Text("\(Int(calorie))kcal")
                .contentTransition(.numericText(value: 605))
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundStyle(Color.keyColor)
                .contentTransition(.numericText())
            
            Spacer()
            
            Text(createDate)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    private var recordInfo: some View {
        HStack(spacing: 12) {
            Group {
                HStack(spacing: 0) {
                    Text("시간 : ")
                    
                    if (hour != 0) {
                        Text("\(Int(hour))시간 ")
                    }
                    
                    Text("\(Int(minute))분")
                }
                
                Text("반복수 : \(Int(repeatedCount))")
                
                Text("평균 심박수 : \(Int(averageHeartRate))bpm")
            }
            .contentTransition(.numericText())
            .font(.system(size: 12))
            .fontWeight(.medium)
            .foregroundStyle(Color.textColor75)
            
            Spacer()
        }
    }
    
    private func calculateAverageHeartRate() {
        averageHeartRate = 0
        intervalRecordEntity.heartRates.forEach { heartRate in
            averageHeartRate += heartRate
        }
        averageHeartRate /= Double(intervalRecordEntity.heartRates.count)
    }
    
    private func calculateCreateDate() {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: .now)
        let currentWeek = calendar.component(.weekOfYear, from: .now)
        
        let createYear = calendar.component(.year, from: intervalRecordEntity.createDate)
        let createWeek = calendar.component(.weekOfYear, from: intervalRecordEntity.createDate)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        
        if currentYear == createYear && currentWeek == createWeek {
            formatter.dateFormat = "EEEE"
        } else if currentYear == createYear {
            formatter.dateFormat = "MM/dd"
        } else {
            formatter.dateFormat = "yyyy/MM/dd"
        }
        createDate = formatter.string(from: intervalRecordEntity.createDate)
    }
    
    private func calculateRecordInfo() {
        calorie = Double(intervalRecordEntity.calorie)
        repeatedCount = Double(intervalRecordEntity.repeatedCount)
        
        hour = Double(intervalRecordEntity.secondTime / 3600)
        minute = Double((intervalRecordEntity.secondTime - Int(hour * 3600)) / 60)
    }
}
