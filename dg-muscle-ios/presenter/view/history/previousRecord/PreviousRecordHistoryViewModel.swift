//
//  PreviousRecordHistoryViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

final class PreviousRecordHistoryViewModel: ObservableObject {
    @Published var dateString: String = ""
    @Published var exerciseName: String = ""
    @Published var volume: Int = 0
    @Published var setsCount: Int = 0
    @Published var sets: [ExerciseSetV] = []
    
    private let record: RecordV
    private let date: Date
    private let getExerciseUsecase: GetExerciseUsecase
    
    private var cancellables = Set<AnyCancellable>()
    init(record: RecordV, date: Date, getExerciseUsecase: GetExerciseUsecase) {
        self.record = record
        self.date = date
        self.getExerciseUsecase = getExerciseUsecase
        
        bind()
    }
    
    private func bind() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        dateString = dateFormatter.string(from: date)
        exerciseName = getExerciseUsecase.implement(exerciseId: record.exerciseId)?.name ?? "Can't find exercise"
        volume = Int(record.volume)
        sets = record.sets
        setsCount = sets.count
    }
}
