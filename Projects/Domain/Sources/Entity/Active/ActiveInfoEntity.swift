//
//  IntervalState.swift
//  Domain
//
//  Created by 김도형 on 2/23/24.
//

import Foundation

public struct ActiveInfoEntity: Codable {
    public let currentCount: Int
    public let isBurning: Bool
    public let startDate: Date
    
    public init(currentCount: Int, isBurning: Bool, startDate: Date) {
        self.currentCount = currentCount
        self.isBurning = isBurning
        self.startDate = startDate
    }
}
