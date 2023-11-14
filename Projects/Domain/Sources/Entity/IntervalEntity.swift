//
//  IntervalEntity.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public struct IntervalEntity {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}

extension IntervalEntity {
    static let mocks: [IntervalEntity] = [
        .init(title: "달리기 인터벌"),
        .init(title: "자전거 인터벌"),
        .init(title: "수영 인터벌"),
        .init(title: "천국의 계단 인터벌"),
        .init(title: "커스텀 인터벌"),
    ]
}
