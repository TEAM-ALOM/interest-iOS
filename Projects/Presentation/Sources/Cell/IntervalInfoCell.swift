//
//  IntervalInfoCell.swift
//  Presentation
//
//  Created by 최유경 on 2/11/24.
//

import Foundation
import SwiftUI
import Domain
import SharedDesignSystem

public struct IntervalInfoCell<ViewModel: IntervalListViewModelInterface>: View {
    private let viewModel: ViewModel
    
    @State private var interval: IntervalEntity
    @State private var cellOffsetX = CGFloat.zero
    
    public init(viewModel: ViewModel, interval: IntervalEntity) {
        self.viewModel = viewModel
        self._interval = State(initialValue: interval)
    }
    
    public var body: some View {
        Button {
            viewModel.tapIntervalDetailPageButton(interval: interval)
        } label: {
            ZStack {
                tool
                cell
            }
        }
    }
    
    private var tool: some View {
        HStack(spacing: 12) {
            toolButton(imageName: "trash",
                       color: .warningColor,
                       backgroundColor: .warningColor) {
                viewModel.tapIntervalDeleteButton(at: interval.id)
            }
            
            toolButton(imageName: "pencil",
                       color: .editColor,
                       backgroundColor: .editColor
            ) {
                viewModel.tapIntervalEditButton(selectedInterval: $interval)
            }
            
            Spacer()
        }
        .scaleEffect(cellOffsetX < 0 ? 0 : cellOffsetX / 90, anchor: .leading)
    }
    
    private var cell: some View {
        containerView
            .gesture(
                DragGesture()
                    .onChanged({ drag in
                        let dragWidth = drag.translation.width
                        
                        if dragWidth < 0 && cellOffsetX <= .zero {
                            cellOffsetX += 1 / (cellOffsetX - 1)
                        } else {
                            cellOffsetX += (cellOffsetX >= 90 && dragWidth > 0) ? 90 / cellOffsetX : dragWidth
                        }
                    })
                    .onEnded({ drag in
                        withAnimation(.snappy) {
                            print(drag.translation.width)
                            let isEdit = cellOffsetX >= 70 || drag.translation.width > 5
                            cellOffsetX = isEdit ? 90 : .zero
                        }
                    })
            )
            .offset(x: cellOffsetX)
    }
}

public extension IntervalInfoCell {
    private var containerView: some View {
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
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: interval.exerciseType.systemImageName)
                .foregroundStyle(Color.keyColor)
            
            Text(interval.title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    @ViewBuilder
    private func infoCell(minute: Int, phase: String, label: () -> some View) -> some View {
        HStack(spacing: 4) {
            label()
            
            Text("\(minute)분 / \(phase)구간")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    private var info: some View {
        VStack(alignment: .trailing, spacing: 20) {
            infoCell(minute: calculateMinutes(minute: interval.burningSecondTime), phase: String(interval.burningHeartIntervalType.heartTypeName.prefix(1))) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.burningColor)
            }
            
            infoCell(minute: calculateMinutes(minute: interval.restingSecondTime), phase: String(interval.restingHeartIntervalType.heartTypeName.prefix(1))) {
                Image(systemName: "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.restColor)
            }
        }
    }
    
    private func calculateMinutes(minute: Int) -> Int {
        let result = minute / 60
        return result
    }
    
    @ViewBuilder
    func toolButton(imageName: String,
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
}
