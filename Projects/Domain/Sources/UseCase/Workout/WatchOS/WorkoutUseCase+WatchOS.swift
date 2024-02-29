//
//  WorkoutUseCase+WatchOS.swift
//  Domain
//
//  Created by 김도형 on 2/26/24.
//

import Foundation

#if os(watchOS)
extension WorkoutUseCase {
    public func sendActiveInfoData(_ activeInterval: ActiveIntervalEntity) {
        workoutRepository.sendActiveInfoData(activeInterval)
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeCalorie(updateHandler: updateHandler)
    }
}
#endif
