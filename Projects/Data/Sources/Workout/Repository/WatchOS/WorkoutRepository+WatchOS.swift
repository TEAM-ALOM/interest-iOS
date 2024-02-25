//
//  WorkoutRepository+WatchOS.swift
//  Data
//
//  Created by 김도형 on 2/23/24.
//

import Foundation
import Domain

#if os(watchOS)
public extension WorkoutRepository {
    func sendActiveInfoData(_ activeInfo: ActiveInfoEntity) {
        dataSource.sendActiveInfoData(activeInfo)
    }
}
#endif
