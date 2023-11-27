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
    func watchIntervalSelectDependencies(intervalRouter: WatchIntervalRouter) -> WatchIntervalSelectViewModel
    func watchIntervalBurningDependencies(intervalRouter: WatchIntervalRouter) -> WatchIntervalActiveViewModel
    func watchIntervalRestingDependencies(intervalRouter: WatchIntervalRouter) -> WatchIntervalActiveViewModel
    func watchIntervalStateManageDependencies(intervalRouter: WatchIntervalRouter) -> WatchIntervalStateViewModel
    
}
