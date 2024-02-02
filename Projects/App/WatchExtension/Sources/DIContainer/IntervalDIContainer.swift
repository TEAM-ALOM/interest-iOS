//
//  IntervalDIContainer.swift
//  InterestWatchExtension
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI

import Presentation
import Domain
import Data

//public final class IntervalDIContainer: IntervalDIContainerInterface {
//    public func intervalRouter() -> IntervalRouter {
//        return IntervalRouter(intervalDIContainer: self)
//    }
//    
//    public func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel {
//        let intervalDataSource = IntervalDataSource()
//        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
//        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
//        
//        return IntervalViewModel(
//            router: intervalRouter,
//            intervalUseCase: intervalUseCase
//        )
//    }
//
//    public func intervalActiveDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> IntervalActiveViewModel {
//        let intervalDataSource = IntervalDataSource()
//        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
//        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
//        
//        let intervalRecordDataSource = IntervalRecordDataSource()
//        let intervalRecordRepository = IntervalRecordRepository(dataSource: intervalRecordDataSource)
//        let intervalRecordUseCase = IntervalRecordUseCase(intervalRecordRepository: intervalRecordRepository)
//        
//        return IntervalActiveViewModelWithRouter(
//            router: intervalRouter,
//            intervalUseCase: intervalUseCase,
//            intervalRecordUseCase: intervalRecordUseCase,
//            intervalItem: intervalItem
//        )
//    }
//    
//    public func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModel {
//        let intervalDataSource = IntervalDataSource()
//        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
//        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
//        
//        return IntervalListViewModelWithRouter(
//            router: intervalRouter,
//            intervalUseCase: intervalUseCase
//        )
//    }
//    
//    public func addIntervalDependencies(intervalRouter: IntervalRouter, intervalItem: Binding<IntervalModel>?) -> AddIntervalViewModel {
//        let intervalDataSource = IntervalDataSource()
//        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
//        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
//    
//        return AddIntervalViewModelWithRouter(
//            router: intervalRouter,
//            intervalUseCase: intervalUseCase,
//            intervalItem: intervalItem
//        )
//    }
//
//    public func intervalDetailDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> IntervalDetailViewModel {
//        let intervalRecordDataSource = IntervalRecordDataSource()
//        let intervalRecordRepository = IntervalRecordRepository(dataSource: intervalRecordDataSource)
//        let intervalRecordUseCase = IntervalRecordUseCase(intervalRecordRepository: intervalRecordRepository)
//        
//        return IntervalDetailViewModelWithRouter(
//            router: intervalRouter,
//            intervalRecordUseCase: intervalRecordUseCase,
//            intervalItem: intervalItem
//        )
//    }
//}
