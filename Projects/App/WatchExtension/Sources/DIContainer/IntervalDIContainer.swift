//
//  IntervalDIContainer.swift
//  InterestWatchExtension
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import Foundation

import Presentation
import Domain
import Data

public final class IntervalDIContainer: IntervalDIContainerInterface {
    public func intervalRouter() -> IntervalRouter {
        return IntervalRouter(intervalDIContainer: self)
    }
    
    public func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalViewModel(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalListViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func intervalActiveDependencies(intervalRouter: IntervalRouter) -> IntervalActiveViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalActiveViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func addIntervalDependencies(intervalRouter: IntervalRouter) -> AddIntervalViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return AddIntervalViewModel(router: intervalRouter)
    }
    
    public func intervalDetailDependencies(intervalRouter: IntervalRouter) -> IntervalDetailViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalDetailViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
}
