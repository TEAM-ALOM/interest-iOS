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
    private let intervalUseCase: IntervalUseCaseInterface
    //private let result : Int
    
    @Published var intervalItems: [IntervalModel] = []
    
    @Published var name: String = ""
    @Published var exercise : [ExerciseImage] = ExerciseImage.allCases
    @Published var selectedExerciseId: ExerciseImage.ID?

    @Published var burningSelectedInterval = HeartSection.section1
    @Published var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var restSelectedInterval = HeartSection.section1
    @Published var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var repeatCounts : RepeatCount = .init(counts: 0)
        
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func calculateBurningTime(){
        let result = Int(burningTime.hours) * 3600 + burningTime.minutes * 60 + burningTime.seconds
    }
    
    func tapSaveButton(at id: UUID) {
        let _ = intervalUseCase.update(at: id, to: IntervalEntity(id: id, title: name, burningSecondTime: 200, burningHeartIntervalType: .five, restingSecondTime: 200, restingHeartIntervalType: .one, repeatCount: 3, records: .init()))
    }
    
}





