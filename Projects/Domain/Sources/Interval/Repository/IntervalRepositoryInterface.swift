//
//  IntervalRepositoryInterface.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public protocol IntervalRepositoryInterface {
    func fetchIntervals() -> [IntervalEntity]
}
