//
//  HistoryFormRecordItemViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation
import Combine

final class HistoryFormRecordItemViewModel: ObservableObject {
    
    @Published var exercise: ExerciseV?
    @Published var setsCount: Int = 0
    @Published var volume: Double = 0
    
    let record: RecordV
    private let getExerciseUsecase: GetExerciseUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: RecordV, getExerciseUsecase: GetExerciseUsecase) {
        self.record = record
        self.getExerciseUsecase = getExerciseUsecase
        self.setsCount = record.sets.count
        self.volume = record.volume
        
        if let exerciseDomain = getExerciseUsecase.implement(exerciseId: record.exerciseId) {
            exercise = .init(from: exerciseDomain)
        }
    }
}
