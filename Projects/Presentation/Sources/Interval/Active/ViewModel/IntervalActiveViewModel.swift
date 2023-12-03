//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

import Domain

public class IntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var activeTime: TimeInterval = 0
    
    init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func tapIntervalStartButton() {
        
    }
}
