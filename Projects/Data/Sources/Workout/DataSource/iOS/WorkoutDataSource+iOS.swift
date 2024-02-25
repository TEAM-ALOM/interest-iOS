//
//  WorkoutDataSource+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit
import Domain

#if os(iOS)
public extension WorkoutDataSource {
    func observeActiveInfoData(updateHandler: @escaping (ActiveInfoEntity) -> Void) {
        manager.subscribeActiveInfoData { data in
            do {
                let activeInfo = try JSONDecoder().decode(ActiveInfoEntity.self, from: data)
                updateHandler(activeInfo)
            } catch {
                print(error)
            }
        }
    }
}
#endif
