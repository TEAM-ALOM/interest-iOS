//
//  WatchIntervalRepositoryInterface.swift
//  WatchDomain
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

public protocol WatchIntervalRepositoryInterface {
    func fetchIntervals() -> [WatchIntervalEntity]
}
