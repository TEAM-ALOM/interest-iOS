//
//  IntervalListIPhoneScreen.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem
import Presentation
import Domain

public struct IntervalListIPhoneScreen: View {
    @State var viewModel: IntervalListViewModel
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.intervalItems) { item in
                    IntervalInfoCellView(viewModel: viewModel, intervalItem: item)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
        }
        .mainBackground()
        .onAppear {
            viewModel.fetchIntervalItems()
        }
    }
}

public struct IntervalInfoCellView: View {
    @State private var cellOffsetX = CGFloat.zero
    @State var viewModel: IntervalListViewModel
    @State var intervalItem: IntervalEntity
    
    public init(viewModel: IntervalListViewModel, intervalItem: IntervalEntity) {
        self._viewModel = .init(wrappedValue: viewModel)
        self._intervalItem = .init(wrappedValue: intervalItem)
    }
    
    public var body: some View {
        Button {
            viewModel.tapIntervalDetailPageButton(intervalItem: intervalItem)
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
                viewModel.tapIntervalDeleteButton(at: intervalItem.id)
            }
            
            toolButton(imageName: "pencil",
                       color: .editColor,
                       backgroundColor: .editColor
            ) {
                viewModel.tapIntervalEditButton(selectedItem: $intervalItem)
            }
            
            Spacer()
        }
        .scaleEffect(cellOffsetX < 0 ? 0 : cellOffsetX / 90, anchor: .leading)
    }
    
    private var cell: some View {
        IntervalInfoCell(intervalEntity: $intervalItem)
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
