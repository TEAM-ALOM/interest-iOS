//
//  WorkoutRepository+WatchOS.swift
//  Data
//
//  Created by 김도형 on 2/26/24.
//

import Foundation
import Domain

#if os(watchOS)
extension WorkoutRepository {
    public func sendActiveInfoData(_ activeInterval: ActiveIntervalEntity) {
        dataSource.sendActiveInfoData(activeInterval)
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeCalorie(updateHandler: updateHandler)
    }
}
#endif
