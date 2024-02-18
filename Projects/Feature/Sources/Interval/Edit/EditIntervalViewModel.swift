//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI
import Domain
import Dependencies

@Observable
public final class EditIntervalViewModelWithRouter: EditIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalEntity : IntervalEntity
    ) {
        self.router = router
        super.init(intervalEntity: intervalEntity)
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
        
    public enum Action {
        case delegate(Delegate)
        
        public enum Delegate {
            case fetched(IntervalEntity)
        }
    }
    
    public var send: ((Action.Delegate) -> ())?
    
    public var intervalEntity : IntervalEntity
    
    public init(
        intervalEntity : IntervalEntity
    ) {
        _intervalEntity = intervalEntity
    }

    func tapCancelButton() {}
    
    func tapSaveButton() {
        let entity = intervalEntity
        let result = intervalUseCase.update(at: entity.id, to: entity)
        send?(.fetched(entity))
    }
}
