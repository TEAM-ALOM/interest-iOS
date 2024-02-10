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
    private var intervalEntity : IntervalEntity
    
    public init(
        router: IntervalRouter,
        intervalEntity : IntervalEntity
    ) {
        self.router = router
        self._intervalEntity = intervalEntity
        super.init(intervalItem: intervalEntity)
    }
}

@Observable
public class EditIntervalViewModel{
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
        
    public var intervalItem : IntervalEntity
    
    public init(
        intervalItem : IntervalEntity
    ) {
        self.intervalItem = intervalItem
    }

    func tapSaveButton() {
        let entity = intervalItem
        let result = intervalUseCase.update(at: entity.id, to: entity)
    }
}
