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
    @Published var showEditIntervalView: Bool = false
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func fetchIntervalItems() {
        // TODO: 실제 데이터 생성 이후에 사용
//        intervalItems = intervalUseCase.fetchIntervals().map {
//            IntervalModelMapper.toPresentationModel(entity: $0)
//        }
        intervalItems = IntervalItem.mocks
        
    }
    
    func tapIntervalDetailPageButton() { }
    
    func tapIntervalEditButton() {
        showEditIntervalView = true
    }
}
