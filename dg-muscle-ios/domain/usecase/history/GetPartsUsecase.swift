//
//  GetPartsUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetPartsUsecase {
    let history: HistoryDomain
    let exerciseRepository: ExerciseRepository
    
    init(history: HistoryDomain, exerciseRepository: ExerciseRepository) {
        self.history = history
        self.exerciseRepository = exerciseRepository
    }
    
    func implement() -> [ExerciseDomain.Part] {
        let exerciseIds = history.records.map { $0.exerciseId }
        let exercises = exerciseRepository.exercises.filter({ exerciseIds.contains($0.id) })
        var parts: [ExerciseDomain.Part] = exercises.flatMap({ $0.parts })
        parts = Array(Set(parts))
        parts.sort(by: { $0.rawValue < $1.rawValue })
        return parts
    }
}
