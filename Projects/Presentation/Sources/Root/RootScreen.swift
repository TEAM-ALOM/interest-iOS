//
//  RootScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

struct RootScreen: View {
    @StateObject var intervalRouter: IntervalRouter = .init()
    
    var body: some View {
        NavigationStack(path: $intervalRouter.navigationPath) {
            IntervalScreen(router: intervalRouter)
        }
    }
}

#Preview {
    RootScreen(intervalRouter: IntervalRouter())
}
