//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain

public class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapIntervalDetailPageButton() {
        super.tapIntervalDetailPageButton()
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
    
    func tapIntervalDetailPageButton() { }
}
