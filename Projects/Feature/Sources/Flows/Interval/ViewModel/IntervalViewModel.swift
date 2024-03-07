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
    
    public func handleWorkout() {
        workoutUseCase.subcribeWorkoutSessionState { state in
            print(state)
            switch state {
            case .running:
                guard let uuid = self.workoutUseCase.workoutIntervalId() else {
                    return
                }
                let interval: IntervalEntity = .init(id: uuid)
                
                let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: self.router, interval: interval)
                let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
                self.router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
                break
            case .ended:
                guard !self.router.navigationPath.isEmpty else {
                    break
                }
                self.router.removeScreenTransition()
            default:
                break
            }
        }
    }
    
    public func subscribeStartedInterval() {
#if os(iOS)
        wcSessionUseCase.observeReceivedMessage(key: "INTERVAL_ID") { (id: String) in
            print("\(#function) \(id)")
            
            guard let uuid = UUID(uuidString: id) else {
                return
            }
            
            self.workoutUseCase.workoutSessionMirroring(intervalId: uuid)
        }
#endif
    }
    
    public func requestAuthorization() {
        let _ = workoutUseCase.requestAuthorization()
    }
}
