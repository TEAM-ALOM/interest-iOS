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
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
}

@Observable
public class EditIntervalViewModel{
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase

    var burningSelectedInterval = HeartIntervalTypeModel.one
    var burningTime: Int = 0
    var restSelectedInterval = HeartIntervalTypeModel.one
    var restTime: Int = 0
    
    var name: String = ""
    
    
    init() {}
    
    func tapSaveButton() {
        //let entity = IntervalModelMapper.toEntity(model: intervalItem.wrappedValue)

        //let _ = intervalUseCase.update(at: entity.id, to: entity)
    }
}
