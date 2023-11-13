//
//  AppDIContainer.swift
//  InterestApp
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

import Presentation
import Domain
import Data

public protocol IntervalDIContainerInterface {
    var intervalRouter: IntervalRouter { get set }
    
    func intervalScreenDependencies() -> IntervalViewModel
    func intervalListDependencies() -> IntervalListViewModel
}

public final class IntervalDIContainer: IntervalDIContainerInterface {
    public var intervalRouter: IntervalRouter = .init()
    
    public func intervalScreenDependencies() -> IntervalViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalViewModel(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
    
    public func intervalListDependencies() -> IntervalListViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return IntervalListViewModelWithRouter(
            router: intervalRouter,
            intervalUseCase: intervalUseCase
        )
    }
}
