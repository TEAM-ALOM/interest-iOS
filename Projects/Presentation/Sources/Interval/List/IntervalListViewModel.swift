//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain

class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter
    
    init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapIntervalDetailPageButton() {
        router.triggerScreenTransition(route: .intervalDetail)
    }
}


public class IntervalListViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItems: [IntervalItem] = []
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetchIntervals().map {
            IntervalModelMapper.toPresentationModel(entity: $0)
        }
    }
    
    func tapIntervalDetailPageButton() {
        
    }
    
//    func triggerTransition(route: IntervalRouter.PushRoute) {
//        router?.triggerScreenTransition(route: route)
//    }
//    
//    func nextScreen() -> some View {
//        router?.nextTransitionScreen()
//    }
}
