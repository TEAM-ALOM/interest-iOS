//
//  IntervalDetailScreen.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI
import SharedDesignSystem
import Presentation

struct IntervalDetailScreen: View {
    @State private var viewModel: IntervalDetailViewModel
    
    init(viewModel: IntervalDetailViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("인터벌 기록")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.textColor)
                
                LazyVStack(spacing: 24) {
                    ForEach(viewModel.interval.records) { record in
                        IntervalRecordCellView(intervalRecordEntity: record)
                    }
                }
                .padding(.bottom, 160)
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
        }
        .navigationTitle(viewModel.interval.title)
        .overlay(alignment: .bottom) {
            startButton
        }
        .ignoresSafeArea(edges: .bottom)
        .mainBackground()
    }
    
    private var startButton: some View {
        Button(action: {
            viewModel.tapIntervalStartButton(interval: viewModel.interval)
        }, label: {
            HStack {
                Spacer()
                
                Image(systemName: "play.circle.fill")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.backgroundColor, Color.keyColor)
                    .shadow(color: .black.opacity(0.25), radius: 10)
                
                Spacer()
            }
            .padding(.bottom, 52)
            .background(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(LinearGradient(colors: [.clear, .keyColor], startPoint: .top, endPoint: .center))
                    .frame(height: 140)
            }
        })
    }
}
