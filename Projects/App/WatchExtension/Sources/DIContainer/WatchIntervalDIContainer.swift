//
//  WatchIntervalDIContainer.swift
//  InterestApp
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchPresentation
import WatchDomain
import WatchData

public final class WatchIntervalDIContainer: WatchIntervalDIContainerInterface {

    public func watchIntervalRouter() -> WatchPresentation.WatchIntervalRouter {
        return WatchIntervalRouter(watchIntervalDIContainer: self)

    }
    
    public func watchIntervalScreenDependencies(intervalRouter: WatchIntervalRouter) -> WatchPresentation.WatchIntervalViewModel {
        
        let intervalDataSource = WatchIntervalDataSource()
        
        let intervalRepository = WatchIntervalRepository(dataSource: intervalDataSource)
        
        let intervalUseCase = WatchIntervalUseCase(watchIntervalRepository: intervalRepository)
        
        return WatchIntervalViewModel(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    public func watchIntervalSelectDependencies(intervalRouter: WatchIntervalRouter) -> WatchPresentation.WatchIntervalSelectViewModel {
        let intervalDataSource = WatchIntervalDataSource()
        
        let intervalRepository = WatchIntervalRepository(dataSource: intervalDataSource)
        
        let intervalUseCase = WatchIntervalUseCase(watchIntervalRepository: intervalRepository)
        
        return WatchIntervalSelectViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func watchIntervalActiveDependencies(intervalRouter: WatchIntervalRouter) -> WatchPresentation.WatchIntervalActiveViewModel {
        
        let intervalDataSource = WatchIntervalDataSource()
        
        let intervalRepository = WatchIntervalRepository(dataSource: intervalDataSource)
        
        let intervalUseCase = WatchIntervalUseCase(watchIntervalRepository: intervalRepository)
        
        return WatchIntervalActiveViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func watchIntervalStateManageDependencies(intervalRouter: WatchIntervalRouter) -> WatchPresentation.WatchIntervalStateViewModel {
        let intervalDataSource = WatchIntervalDataSource()
        
        let intervalRepository = WatchIntervalRepository(dataSource: intervalDataSource)
        
        let intervalUseCase = WatchIntervalUseCase(watchIntervalRepository: intervalRepository)
        
        return WatchIntervalStateViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
}
