//
//  IntervalModel.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation

public struct IntervalItem: Identifiable {
    public var id: UUID = .init()
    
    public var title: String
}

public extension IntervalItem {
    static let mocks: [IntervalItem] = [
        .init(title: "달리기 인터벌"),
        .init(title: "자전거 인터벌"),
        .init(title: "수영 인터벌"),
        .init(title: "천국의 계단 인터벌"),
        .init(title: "커스텀 인터벌"),
    ]
}
