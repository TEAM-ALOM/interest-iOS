//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain
import SharedThirdPartyLib
import Dependencies
import Perception

@Observable 
public final class IntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.workoutUseCase) var workoutUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    private let router: IntervalRouter
    
    public var intervalListViewModel: IntervalListViewModel
    
    public var isBottomSheetPresent = false
    
    public init(router: IntervalRouter) {
        self.router = router
        self.intervalListViewModel = IntervalListViewModelWithRouter(router: router)
    }

    public func tapPlusButton() {
        let addIntervalViewModel: AddIntervalViewModel = AddIntervalViewModelWithRouter(router: router)
        let addIntervalRoute: IntervalRouter.PresentationRoute = .addInterval(addIntervalViewModel)
        
        addIntervalViewModel.send =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .saved(entity):
                self.intervalListViewModel.append(interval: entity)
            }
            
        }
        router.triggerPresentationScreen(presentationRoute: addIntervalRoute)
    }
    
    public func subscribeWorkoutState() {
        workoutUseCase.observeWorkoutState { [weak self] state in
            guard let `self` = self else { return }
            print(state)
            switch state {
            case .running:
                guard let interval = self.workoutUseCase.checkCurrentInterval() else {
                    break
                }
                
                let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: self.router, interval: interval)
                let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
                self.router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
                break
            case .notStarted:
                break
            case .ended:
                self.router.removeScreenTransition()
            default:
                break
            }
        }
    }
    
    public func subscribeWorkoutSessionReady() {
        #if os(iOS)
        self.wcSessionUseCase.observeReceiveMessageValue(key: "WORKOUT_READY_WATCH") { [weak self] (ready: Bool) in
            guard let `self` = self else { return }
            print(ready)
            if ready, let interval = self.workoutUseCase.checkCurrentInterval() {
                self.wcSessionUseCase.sendMessage(["INTERVAL_ID": interval.id.uuidString])
            }
        }
        #endif
        
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_ID") { [weak self] (id: String) in
            guard let `self` = self else { return }
            self.workoutUseCase.startWorkout(interval: .init(id: UUID(uuidString: id)!))
        }
    }
    
    public func requestingAuthorization() {
        print(workoutUseCase.requestAuthorization())
    }
}
