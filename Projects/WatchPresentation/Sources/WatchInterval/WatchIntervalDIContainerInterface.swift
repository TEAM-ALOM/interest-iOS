//
//  WatchIntervalDIContainerInterface.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

public protocol WatchIntervalDIContainerInterface {
    func watchIntervalRouter() -> WatchIntervalRouter
    func watchIntervalScreenDependencies(intervalRouter: WatchIntervalRouter) -> WatchIntervalViewModel
    func watchIntervalSelectDependencies(intervalRouter: WatchIntervalRouter) -> IntervalSelectViewModel
    func watchIntervalBurningDependencies(intervalRouter: WatchIntervalRouter) -> IntervalActiveViewModel
    func watchIntervalRestingDependencies(intervalRouter: WatchIntervalRouter) -> IntervalActiveViewModel
    
}
