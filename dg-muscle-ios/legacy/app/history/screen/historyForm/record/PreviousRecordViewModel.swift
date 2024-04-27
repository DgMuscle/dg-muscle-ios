//
//  PreviousRecordViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine

final class PreviousRecordViewModel: ObservableObject {
    @Published var record: Record
    @Published var dateString: String
    @Published var exercise: Exercise? = nil
    
    let exerciseRepository: ExerciseRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Record, date: Date, exerciseRepository: ExerciseRepositoryV2) {
        self.record = record
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        self.dateString = dateFormatter.string(from: date)
        
        self.exerciseRepository = exerciseRepository
        
        configureExercise()
    }
    
    private func configureExercise() {
        let exercises = exerciseRepository.exercises
        self.exercise = exercises.first(where: { $0.id == record.exerciseId })
    }
}
