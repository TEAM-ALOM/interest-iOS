//
//  WorkoutDataSource+WatchOS.swift
//  Data
//
//  Created by 김도형 on 2/23/24.
//

import Foundation
import Domain

#if os(watchOS)
public extension WorkoutDataSource {
    func sendActiveInfoData(_ activeInfo: ActiveInfoEntity) {
        do {
            let data = try JSONEncoder().encode(activeInfo)
            manager.sendActiveInfoData(data)
        } catch {
            print(error)
        }
    }
}
#endif
