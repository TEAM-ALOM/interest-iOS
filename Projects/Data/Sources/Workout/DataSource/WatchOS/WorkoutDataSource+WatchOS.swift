//
//  WorkoutDataSource+WatchOS.swift
//  Data
//
//  Created by 김도형 on 2/25/24.
//

import Foundation
import Domain

#if os(watchOS)
extension WorkoutDataSource {
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        manager.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        manager.subcribeCalorie(updateHandler: updateHandler)
    }
    
    public func sendActiveInfoData(_ activeInterval: ActiveIntervalEntity) {
        guard let data = try? JSONEncoder().encode(activeInterval) else {
            return
        }
        manager.sendActiveInfoData(data)
    }
}
#endif
