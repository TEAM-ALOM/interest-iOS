//
//  WatchIntervalEntity.swift
//  WatchDomain
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

public struct WatchIntervalEntity {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}

extension WatchIntervalEntity {
    static let mocks: [WatchIntervalEntity] = [
        .init(title: "달리기"),
        .init(title: "자전거"),
        .init(title: "수영"),
        .init(title: "천국의 계단"),
        .init(title: "커스텀"),
    ]
}
