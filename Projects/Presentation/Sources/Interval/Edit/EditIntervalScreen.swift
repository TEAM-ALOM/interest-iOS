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

    //intervalForm
    private var IntervalForm: some View {
        VStack (alignment: .leading) {
            Text("이름")
                .font(.system(size: 17))
            
            HStack () {
                Text("달리기 인터벌")
                    .padding(13)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .foregroundColor(Color.textColor50)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorScheme == .dark ? Color.textColor25 : Color.textColor75)

            }
            .padding(.bottom, 28)
            
            
            //버닝 픽커
            expandableTimeIntervalPicker(isBurning: true, selection: $viewModel.burningSelectedInterval, totalTime: $viewModel.burningTime)
                .padding(.bottom, 25)
            
            //휴식 픽커
            expandableTimeIntervalPicker(isBurning: false, selection: $viewModel.restSelectedInterval, totalTime: $viewModel.restTime)
            
        }
        .padding(.horizontal, 24)
    }
}

