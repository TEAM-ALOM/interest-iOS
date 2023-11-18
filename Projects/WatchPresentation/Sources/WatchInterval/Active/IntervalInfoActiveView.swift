//
//  WatchIntervalInfoView.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import SwiftUI
import WatchSharedDesignSystem

struct IntervalInfoActiveView: View {
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("인터벌")
                    Spacer()
                }
                HStack{
                    Text("심박수")
                    Spacer()
                }
                HStack{
                    Text("칼로리")
                    Spacer()
                }
                HStack{
                    Text("진행시간")
                    Spacer()
                }
            }
            .foregroundColor(Color.textColor50)
            .padding(.horizontal,12)
            Spacer()
        }
    }
}

#Preview {
    IntervalInfoActiveView()
}
