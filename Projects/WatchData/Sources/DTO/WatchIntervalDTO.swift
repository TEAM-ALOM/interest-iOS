//
//  WatchIntervalDTO.swift
//  WatchData
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchDomain

public struct WatchIntervalDTO {
    public let title: String
    
    public func toEntity() -> WatchIntervalEntity {
        return .init(title: self.title)
    }
}

extension WatchIntervalDTO {
    static let mocks: [WatchIntervalDTO] = [
        .init(title: "달리기"),
        .init(title: "자전거"),
        .init(title: "수영"),
        .init(title: "천국의 계단"),
        .init(title: "커스텀"),
    ]
}
