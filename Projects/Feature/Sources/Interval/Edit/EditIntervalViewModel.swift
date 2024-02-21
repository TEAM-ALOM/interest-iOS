//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI
import Domain

import SharedThirdPartyLib
import Dependencies
import Perception

@Observable
public final class EditIntervalViewModelWithRouter: EditIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        interval: IntervalEntity
    ) {
        self.router = router
        super.init(interval: interval)
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
public class EditIntervalViewModel{
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
        
    public enum Action {
        case delegate(Delegate)
        
        public enum Delegate {
            case fetched(IntervalEntity)
        }
    }
    
    public var send: ((Action.Delegate) -> ())?
    
    public var interval: IntervalEntity
    
    public init(
        interval: IntervalEntity
    ) {
        _interval = interval
    }

    func tapCancelButton() {}
    
    func tapSaveButton() {
        let entity = interval
        let result = intervalUseCase.update(at: entity.id, to: entity)
        if result != nil {
            wcSessionUseCase.sendData(["INTERVAL_UPDATE": entity])
        }
        send?(.fetched(entity))
    }
}
