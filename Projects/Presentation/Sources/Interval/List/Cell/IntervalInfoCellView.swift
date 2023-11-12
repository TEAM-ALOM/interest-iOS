//
//  IntervalInfoCellView.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import SwiftUI

public struct IntervalInfoCellView: View {
    public var item: IntervalInfoCellItem
    
    init(item: IntervalInfoCellItem) {
        self.item = item
    }
    
    public var body: some View {
        HStack {
            titleView
            
            Spacer()
        }
    }
    
    private var titleView: some View {
        VStack(alignment: .leading) {
            Image(systemName: "figure.pool.swim")
            
            Text(self.item.title)
        }
    }
}
