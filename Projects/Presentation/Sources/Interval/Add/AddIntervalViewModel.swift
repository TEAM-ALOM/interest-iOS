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

public class AddIntervalViewModelWithRouter: AddIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapSaveButton() {
        super.tapSaveButton()
    }
    
}

public class AddIntervalViewModel: ObservableObject {
    let intervalUseCase: IntervalUseCaseInterface
    
    @Published var name: String = ""
    @Published var repeatCounts : Int = 0
    
    @Published var exercise : [ExerciseTypeModel] = ExerciseTypeModel.allCases
    @Published var selectedExerciseType: ExerciseTypeModel?
    
    
    @Published var burningSelectedInterval = HeartIntervalTypeModel.one
    @Published var burningTime: Int = 0
    @Published var restingSelectedInterval = HeartIntervalTypeModel.one
    @Published var restingTime: Int = 0
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func tapSaveButton() {
        let newInterval = IntervalEntity(
            id: .init(),
            title: name,
            exerciseType: ExerciseTypeModelMapper.toEntity(model: selectedExerciseType ?? ExerciseTypeModel.run),
            burningSecondTime: burningTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: burningSelectedInterval),
            restingSecondTime: restingTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: restingSelectedInterval),
            repeatCount: repeatCounts,
            records: []
        )
        
        intervalUseCase.save(interval: newInterval)
    }
}

