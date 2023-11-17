//
//  WatchIntervalUseCase.swift
//  WatchDomain
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import Combine

public protocol WatchIntervalUseCaseInterface {
    func fetchIntervals() -> [WatchIntervalEntity]
}

public final class WatchIntervalUseCase: WatchIntervalUseCaseInterface {
    private let watchIntervalRepository: WatchIntervalRepositoryInterface
    
    public init(watchIntervalRepository: WatchIntervalRepositoryInterface) {
        self.watchIntervalRepository = watchIntervalRepository
    }
    
    public func fetchIntervals() -> [WatchIntervalEntity] {
        return watchIntervalRepository.fetchIntervals()
    }
}
