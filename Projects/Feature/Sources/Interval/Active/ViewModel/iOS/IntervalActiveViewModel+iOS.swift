//
//  IntervalActiveViewModel+iOS.swift
//  Feature
//
//  Created by 김도형 on 2/23/24.
//

import Foundation
import Domain

#if os(iOS)
extension IntervalActiveViewModel {
    func subscribeActiveInfoData() {
        workoutUseCase.observeActiveInfoData { [weak self] activeInfo in
            guard let `self` = self else { return }
            self.currentCount = activeInfo.currentCount
            self.isBurning = activeInfo.isBurning
            self.startDate = activeInfo.startDate
        }
    }
}
#endif
