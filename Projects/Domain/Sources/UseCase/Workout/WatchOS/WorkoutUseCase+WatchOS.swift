//
//  WorkoutUseCase+WatchOS.swift
//  Domain
//
//  Created by 김도형 on 2/23/24.
//

import Foundation

#if os(watchOS)
public extension WorkoutUseCase {
    func sendActiveInfoData(_ activeInfo: ActiveInfoEntity) {
        workoutRepository.sendActiveInfoData(activeInfo)
    }
}
#endif
