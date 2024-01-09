//
//  AddIntervalViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

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
    
}

public class AddIntervalViewModel: ObservableObject {
    let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItems: [IntervalModel] = []
    
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
    
    func tapSaveButton(at id: UUID) {
        let newInterval = IntervalEntity(
            id: id,
            title: name,
            exerciseType: ExerciseTypeModelMapper.toEntity(model: selectedExerciseType ?? ExerciseTypeModel.run),
            burningSecondTime: burningTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: burningSelectedInterval),
            restingSecondTime: restingTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: restingSelectedInterval),
            repeatCount: repeatCounts,
            records: .init()
        )
        
        let _ = intervalUseCase.update(at: id, to: newInterval)
        
        let newIntervalModel = IntervalModel(
            id: newInterval.id,
            title: newInterval.title,
            exerciseType: ExerciseTypeModelMapper.toPresentationModel(entity: newInterval.exerciseType),
            burningSecondTime: newInterval.burningSecondTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(entity: newInterval.burningHeartIntervalType),
            restingSecondTime: newInterval.restingSecondTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(entity: newInterval.restingHeartIntervalType),
            repeatCount: newInterval.repeatCount,
            records: newInterval.records.map { IntervalRecordModelMapper.toPresentationModel(entity: $0) }
        )
        
        intervalItems.append(newIntervalModel)
        IntervalModel.mocks.append(newIntervalModel)
        
        let _ = intervalUseCase.fetches()
        
    }
}

