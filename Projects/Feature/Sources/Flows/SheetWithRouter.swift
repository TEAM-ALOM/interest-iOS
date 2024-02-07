//
//  SheetWithRouter.swift
//  Presentation
//
//  Created by 송영모 on 1/20/24.
//

import Foundation
import SwiftUI

struct SheetWithRouterViewModifier<Router: FlowRouter>: ViewModifier {
    var router: Router

    @ViewBuilder func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: .init(
                    get: { router.nextPresentationRoute != nil },
                    set: { isPresented in
                        if !isPresented {
                            router.triggerPresentationScreen(presentationRoute: nil)
                        }
                    }
                )
            ) {
                self.router.nextPresentationScreen()
            }
    }
}


extension View {
    @ViewBuilder 
    func sheetWithRouter<Router: FlowRouter>(router: Router) -> some View {
        self.modifier(SheetWithRouterViewModifier(router: router))
    }
}
