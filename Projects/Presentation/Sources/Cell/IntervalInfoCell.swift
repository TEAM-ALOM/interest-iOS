//
//  IntervalInfoCell.swift
//  Presentation
//
//  Created by 최유경 on 2/11/24.
//

import Foundation
import SwiftUI
import Domain

public struct IntervalInfoCell: View {
    @Binding var intervalEntity : IntervalEntity
    
    var buringMinute : Int
    var restingMinute : Int
    
    public init(intervalEntity: Binding<IntervalEntity>) {
        _intervalEntity = intervalEntity
        buringMinute = (intervalEntity.burningSecondTime.wrappedValue) / 60
        restingMinute = (intervalEntity.restingSecondTime.wrappedValue) / 60
    }
    
    public var body: some View {
        HStack {
            titleView
            
            Spacer()
            
            info
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.shapeColor)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 0)
        }
    }
    
    public var titleView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: intervalEntity.exerciseType.systemImageName)
                .foregroundStyle(Color.keyColor)
            
            Text(intervalEntity.title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    @ViewBuilder
    public func infoCell(minute: Int, phase: String, label: () -> some View) -> some View {
        HStack(spacing: 4) {
            label()
            
            Text("\(minute)분 / \(phase)구간")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    public var info: some View {
        VStack(alignment: .trailing, spacing: 20) {
            infoCell(minute: buringMinute, phase: String(intervalEntity.burningHeartIntervalType.heartTypeName.prefix(1))) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.burningColor)
            }
            
            infoCell(minute: restingMinute, phase: String(intervalEntity.restingHeartIntervalType.heartTypeName.prefix(1))) {
                Image(systemName: "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.restColor)
            }
        }
    }
}

@ViewBuilder
public func toolButton(imageName: String,
                       color: Color,
                       backgroundColor: Color,
                       action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 16)
            .foregroundStyle(color)
            .padding(8)
            .background {
                Circle()
                    .foregroundStyle(backgroundColor.opacity(0.2))
            }
    }
}
