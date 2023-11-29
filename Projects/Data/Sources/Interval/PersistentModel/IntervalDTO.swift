//
//  IntervalDTO.swift
//  Data
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

import Domain

public struct IntervalDTO {
    public let title: String
    
    public func toEntity() -> IntervalEntity {
        return .init(title: self.title)
    }
}

extension IntervalDTO {
    static let mocks: [IntervalDTO] = [
        .init(title: "달리기 인터벌"),
        .init(title: "자전거 인터벌"),
        .init(title: "수영 인터벌"),
        .init(title: "천국의 계단 인터벌"),
        .init(title: "커스텀 인터벌"),
    ]
}
