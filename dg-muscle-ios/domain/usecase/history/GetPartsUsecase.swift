//
//  GetPartsUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetPartsUsecase {
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(history: HistoryDomain) -> [ExerciseDomain.Part] {
        let exerciseIds = history.records.map { $0.exerciseId }
        let exercises = exerciseRepository.exercises.filter({ exerciseIds.contains($0.id) })
        var parts: [ExerciseDomain.Part] = exercises.flatMap({ $0.parts })
        parts = Array(Set(parts))
        parts.sort()
        return parts
    }
}
