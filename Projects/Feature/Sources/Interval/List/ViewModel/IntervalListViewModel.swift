//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Presentation
import Domain

import SharedThirdPartyLib
import Dependencies
import Perception
import HealthKit

@Observable
public final class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter

    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
    
    override public func tapIntervalDetailPageButton(interval: IntervalEntity) {
        super.tapIntervalDetailPageButton(interval: interval)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router, interval: interval)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }
#if os(watchOS)
    override public func tapStartButton(interval: IntervalEntity) {
        super.tapStartButton(interval: interval)
        
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: self.router, interval: interval)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        self.router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
#endif

    public override func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>) {
        super.tapIntervalEditButton(selectedInterval: selectedInterval)
        let editIntervalViewModel : EditIntervalViewModel = EditIntervalViewModelWithRouter(router: router, interval: selectedInterval.wrappedValue)
        let editIntervalRoute : IntervalRouter.PresentationRoute = .editInterval(editIntervalViewModel)
        
        editIntervalViewModel.send =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .fetched(entity):
                selectedInterval.wrappedValue = entity
                self.fetchIntervalItems()
            }
        }
        router.triggerPresentationScreen(presentationRoute: editIntervalRoute)
    }

    func editIntervalScreen(selectedInterval: IntervalEntity) -> some View {
        return router.nextPresentationScreen()
    }
}


@Observable
public class IntervalListViewModel: IntervalListViewModelInterface, Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.workoutUseCase) var workoutUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    public let id: UUID = .init()
    
    var intervals: [IntervalEntity] = []
    var selectedInterval: IntervalEntity? = nil
    
    public init() { }
    
    public func append(interval: IntervalEntity) {
        intervals.append(interval)
    }
    
    public func fetchIntervalItems() {
        intervals = intervalUseCase.fetches()
    }
#if os(watchOS)
    public func tapStartButton(interval: IntervalEntity) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = interval.exerciseType.hkWorkoutActivityType
        workoutUseCase.setWorkoutInterval(interval: interval)
        workoutUseCase.startWorkout(configuration: configuration)
    }
#endif
    
    public func tapIntervalDetailPageButton(interval: IntervalEntity) { }
    
    public func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        self.fetchIntervalItems()
    }
    
    public func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>) {
        
    }
}
