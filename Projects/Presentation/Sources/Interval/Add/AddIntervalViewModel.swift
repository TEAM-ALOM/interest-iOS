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
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem: IntervalModel
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase, intervalItem: intervalItem)
    }


    override func tapSaveButton() {
        super.tapSaveButton()
    }

}

public class AddIntervalViewModel: ObservableObject {
    let intervalUseCase: IntervalUseCaseInterface
    
    @State var mode: Mode = .add
    
    enum Mode {
        case add
        case edit
    }
    
    var selectedItemId: UUID? = nil
    
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
    
    public init(intervalUseCase: IntervalUseCaseInterface, intervalItem: IntervalModel) {
        self.intervalUseCase = intervalUseCase
        
        self.mode = .edit
        self.selectedItemId = intervalItem.id
        
        self.name = intervalItem.title
        self.repeatCounts = intervalItem.repeatCount
        
        self.selectedExerciseType = intervalItem.exerciseType
        
        self.burningSelectedInterval = intervalItem.burningHeartIntervalType
        self.burningTime = intervalItem.burningSecondTime
        self.restingSelectedInterval = intervalItem.restingHeartIntervalType
        self.restingTime = intervalItem.restingSecondTime
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
        
        switch self.mode {
        case .add:
            intervalUseCase.save(interval: newInterval)
        case .edit:
            intervalUseCase.update(at: self.selectedItemId!, to: newInterval)
        }
        
    }

}
