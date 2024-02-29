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
    
    override public func tapStartButton(interval: IntervalEntity) {
        super.tapStartButton(interval: interval)
    }

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
        withAnimation(.snappy) {
            intervals = intervalUseCase.fetches()
        }
    }
    
    public func tapStartButton(interval: IntervalEntity) {
        wcSessionUseCase.sendMessage(["INTERVAL_ID": interval.id.uuidString])
        workoutUseCase.startWorkout(interval: interval)
    }
    
    public func observeIntervalMessage() {
        // 아이폰과 워치간의 인터벌 공유를 위한 코드(잘 작동하지 않음)
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_SAVE") { (interval: IntervalEntity) in
            self.intervalUseCase.save(interval: interval)
            self.fetchIntervalItems()
        }
        
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_UPDATE") { (interval: IntervalEntity) in
            let _ = self.intervalUseCase.update(at: interval.id, to: interval)
            self.fetchIntervalItems()
        }
        
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_DELETE") { (id: String) in
            guard let uuid = UUID(uuidString: id) else {
                return
            }
            let _ = self.intervalUseCase.delete(at: uuid)
            self.fetchIntervalItems()
        }
    }
    
    public func tapIntervalDetailPageButton(interval: IntervalEntity) { }
    
    public func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        self.wcSessionUseCase.sendData(["INTERVAL_DELETE": id.uuidString])
        
        self.fetchIntervalItems()
    }
    
    public func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>) {
        
    }
}
