//
//  IntervalUseCase.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import Combine

public protocol IntervalUseCaseInterface {
    func fetchIntervals() -> [IntervalEntity]
}

final class IntervalUseCase: IntervalUseCaseInterface {
    private let intervalRepository: IntervalRepositoryInterface
    
    init(intervalRepository: IntervalRepositoryInterface) {
        self.intervalRepository = intervalRepository
    }
    
    func fetchIntervals() -> [IntervalEntity] {
        return intervalRepository.fetchIntervals()
    }
}
