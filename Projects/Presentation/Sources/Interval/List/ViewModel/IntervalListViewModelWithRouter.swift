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

    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }

    override func tapStartButton() {
        super.tapStartButton()
        router.triggerNavigationScreen(navigationRoute: .intervalActive)
    }

    override func tapIntervalDetailPageButton(intervalItem: IntervalModel) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        router.triggerNavigationScreen(navigationRoute: .intervalDetail(intervalItem))
    }

    func editIntervalScreen(selectedItem: IntervalModel) -> some View {
        return router.nextPresentationScreen()
//        return router.sheetScreen(route: .editInterval(selectedItem))
    }
}
