//
//  AddIntervalViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SwiftData

import Domain
import SharedThirdPartyLib
import Dependencies
import Perception

@Observable
public final class AddIntervalViewModelWithRouter: AddIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
    
    override func tapCancelButton() {
        super.tapCancelButton()
        
        router.triggerPresentationScreen(presentationRoute: nil)
    }
    
    override func tapSaveButton() {
        super.tapSaveButton()
        
        router.triggerPresentationScreen(presentationRoute: nil)
    }
}

@Observable
public class AddIntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    public enum Action {
        case delegate(Delegate)
        
        public enum Delegate {
            case saved(IntervalEntity)
        }
    }
    
    public var send: ((Action.Delegate) -> ())?
    
    public init() {
        self._interval = .init(id: UUID())
    }

    public var interval: IntervalEntity
    
    func tapCancelButton() {}
    
    func tapSaveButton() {
        let entity = interval
        let result = intervalUseCase.save(interval: entity)
        send?(.saved(entity))
    }
}
