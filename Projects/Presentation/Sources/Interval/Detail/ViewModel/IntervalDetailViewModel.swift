//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain

public class IntervalDetailViewModelWithRouter: IntervalDetailViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface,
        intervalModelID: UUID
    ) {
        self.router = router
        super.init(
            intervalUseCase: intervalUseCase,
            intervalModelID: intervalModelID
        )
    }
    
    override func tapIntervalStartButton() {
        super.tapIntervalStartButton()
//        router.triggerScreenTransition(route: .intervalDetail())
    }
}

public class IntervalDetailViewModel: ObservableObject {
    @Published var intervalModel: IntervalModel
    
    private let intervalUseCase: IntervalUseCaseInterface
    
    init(
        intervalUseCase: IntervalUseCaseInterface,
        intervalModelID: UUID
    ) {
        self.intervalUseCase = intervalUseCase
        self.intervalModel = IntervalModel.mocks.first { interval in
            return interval.id == intervalModelID
        } ?? .init(
            title: "달리기 인터벌",
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        )
    }
    
    func tapIntervalStartButton() {
        
    }
}
