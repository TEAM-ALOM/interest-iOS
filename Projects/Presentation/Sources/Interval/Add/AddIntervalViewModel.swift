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
    
    override func calculateTime(){
        burningResult = Int(burningTime.hours) * 3600 + burningTime.minutes * 60 + burningTime.seconds
        restingResult = Int(restTime.hours) * 3600 + restTime.minutes * 60 + restTime.seconds
    }
    
    override func tapSaveButton(at id: UUID) {
        let newInterval = IntervalEntity(
            id: id,
            title: name,
            exerciseId: selectedExerciseId ?? ExerciseImage.run,
            burningSecondTime: burningResult,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: burningSelectedInterval),
            restingSecondTime: restingResult,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(model: restSelectedInterval),
            repeatCount: repeatCounts.counts,
            records: .init()
        )
        
        let _ = intervalUseCase.update(at: id, to: newInterval)
        
        let newIntervalModel = IntervalModel(
            id: newInterval.id,
            title: newInterval.title, 
            exerciseId: newInterval.exerciseId,
            burningSecondTime: newInterval.burningSecondTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(entity: newInterval.burningHeartIntervalType),
            restingSecondTime: newInterval.restingSecondTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(entity: newInterval.restingHeartIntervalType),
            repeatCount: newInterval.repeatCount,
            records: newInterval.records.map { IntervalRecordModelMapper.toPresentationModel(entity: $0) }
        )
        
        intervalItems.append(newIntervalModel)
        
        let _ = intervalUseCase.fetches()
        
    }
    
}
public class AddIntervalViewModel: ObservableObject {
    let intervalUseCase: IntervalUseCaseInterface
    
    var burningResult: Int = 0
    var restingResult: Int = 0
    
    @Published var intervalItems: [IntervalModel] = []
    
    @Published var name: String = ""
    @Published var repeatCounts : RepeatCount = .init(counts: 0)

    @Published var exercise : [ExerciseImage] = ExerciseImage.allCases
    @Published var selectedExerciseId: ExerciseImage.ID?
    
    
    @Published var burningSelectedInterval = HeartIntervalTypeModel.one
    @Published var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var restSelectedInterval = HeartIntervalTypeModel.one
    @Published var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func calculateTime(){}
    
    func tapSaveButton(at id: UUID) {}
}
