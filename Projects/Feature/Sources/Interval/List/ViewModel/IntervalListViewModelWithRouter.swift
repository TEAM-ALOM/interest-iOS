//
//  IntervalListViewModelWithRouter.swift
//  Presentation
//
//  Created by 송영모 on 1/20/24.
//

import Foundation
import SwiftUI

import Domain

@Observable 
public final class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter
    
    private var addIntervalViewModelWithRouter: AddIntervalViewModelWithRouter

    public init(
        router: IntervalRouter
    ) {
        self.router = router
        self.addIntervalViewModelWithRouter = .init(router: router)
        super.init()
    }

    override func tapStartButton(intervalItem: IntervalModel) {
        super.tapStartButton(intervalItem: intervalItem)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
    
    override func tapIntervalDetailPageButton(intervalItem: IntervalModel) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }

    override func tapIntervalEditButton(selectedItem: Binding<IntervalModel>) {
        super.tapIntervalEditButton(selectedItem: selectedItem)
//        router.triggerPresentationScreen(presentationRoute: .editInterval(selectedItem))
    }

    func editIntervalScreen(selectedItem: IntervalModel) -> some View {
        return router.nextPresentationScreen()
    }
}
