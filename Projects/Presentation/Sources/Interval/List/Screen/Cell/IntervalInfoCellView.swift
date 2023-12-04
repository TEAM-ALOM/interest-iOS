//
//  IntervalInfoCellView.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import SwiftUI

import SharedDesignSystem

public struct IntervalInfoCellView: View {
    @ObservedObject private var intervalListViewModel: IntervalListViewModel
    
    @State private var cellOffsetY = CGFloat.zero
    
    public var intervalItem: IntervalItem
    
    init(intervalItem: IntervalItem, intervalListViewModel: IntervalListViewModel) {
        self.intervalItem = intervalItem
        self.intervalListViewModel = intervalListViewModel
    }
    
    public var body: some View {
        ZStack {
            tool
            
            cell
        }
    }
    
    private var tool: some View {
        HStack(spacing: 12) {
            toolButton(imageName: "trash", 
                       color: .warningColor,
                       backgroundColor: .warningColor25) {
                
            }
            
            toolButton(imageName: "pencil", 
                       color: .editColor,
                       backgroundColor: .editColor25) {
                intervalListViewModel.tapIntervalEditButton()
            }
            
            Spacer()
        }
        .scaleEffect(cellOffsetY / 90, anchor: .leading)
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
                        .foregroundStyle(backgroundColor)
                }
        }
    }
    
    private var cell: some View {
        HStack {
            titleView
            
            Spacer()
            
            info
            
            Button(action: {
                //TODO: iOS에서도 실행 창으로 넘어갈 수 있게 설계해야함.
                intervalListViewModel.tapStartButton()
            }) {
                Image(systemName: "play.circle.fill")
                    .foregroundStyle(Color.keyColor)
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.shapeColor)
                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
        }
        .gesture(
            DragGesture()
                .onChanged({ drag in
                    let dragWidth = drag.translation.width
                    
                    if dragWidth < 0 && cellOffsetY == .zero {
                        cellOffsetY = .zero
                    } else {
                        cellOffsetY += (cellOffsetY >= 90) ? dragWidth / 400 : dragWidth
                    }
                })
                .onEnded({ _ in
                    withAnimation(.smooth) {
                        cellOffsetY = (cellOffsetY >= 70) ? 90 : .zero
                    }
                })
        )
        .offset(x: cellOffsetY)
    }
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "figure.pool.swim")
                .foregroundStyle(Color.keyColor)
            
            Text(self.intervalItem.title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor)
        }
    }
    
    @ViewBuilder
    private func infoCell(minute: Int, phase: Int, label: () -> some View) -> some View {
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
            infoCell(minute: 1, phase: 5) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.burningColor)
            }
            
            infoCell(minute: 4, phase: 1) {
                Image(systemName: "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(Color.restColor)
            }
        }
    }
}
