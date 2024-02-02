//
//  IntervalListViewModelWithRouter.swift
//  Presentation
//
//  Created by 송영모 on 1/20/24.
//

import Foundation
import SwiftUI

import Domain

@Observable public final class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter
    
    private var addIntervalViewModelWithRouter: AddIntervalViewModelWithRouter

    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        self.addIntervalViewModelWithRouter = IntervalRouter.NavigationRoute.intervalActive(<#T##IntervalModel#>)
        super.init(intervalUseCase: intervalUseCase)
    }

    override func tapStartButton(intervalItem: IntervalModel) {
            super.tapStartButton(intervalItem: intervalItem)
            router.triggerNavigationScreen(navigationRoute: .intervalActive(intervalItem))
    }
    
    override func tapIntervalDetailPageButton(intervalItem: IntervalModel) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        router.triggerNavigationScreen(navigationRoute: .intervalDetail(intervalItem))
    }

    override func tapIntervalEditButton(selectedItem: Binding<IntervalModel>) {
        super.tapIntervalEditButton(selectedItem: selectedItem)
        router.triggerPresentationScreen(presentationRoute: .editInterval(selectedItem))
    }

    func editIntervalScreen(selectedItem: IntervalModel) -> some View {
        return router.nextPresentationScreen()
//        return router.sheetScreen(route: .editInterval(selectedItem))
    }
}
