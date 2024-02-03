//
//  IntervalListWatchScreen.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalListWatchScreen: View {
    @State var viewModel: IntervalListViewModel
    
    public var body: some View {
        VStack{
            WatchListView(viewModel: viewModel)
                .padding(.top,5)
            Spacer()
            HStack{
                Spacer()
                StartButton(viewModel: viewModel, intervalItem: viewModel.selectedItem!)
                Spacer()
            }
        }
        .mainBackground()
    }
}
