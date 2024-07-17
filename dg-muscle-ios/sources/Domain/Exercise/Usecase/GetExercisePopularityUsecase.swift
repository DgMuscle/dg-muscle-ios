//
//  GetExercisePopularityUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/17/24.
//

import Foundation

public final class GetExercisePopularityUsecase {
    let exerciseRepository: ExerciseRepository
    let historyRepository: HistoryRepository
    
    public init(
        exerciseRepository: ExerciseRepository,
        historyRepository: HistoryRepository
    ) {
        self.exerciseRepository = exerciseRepository
        self.historyRepository = historyRepository
    }
    
    public func implement() -> [String: Double] {
        var result: [String: Double] = [:]
        
        let allExercises = exerciseRepository.get()
        let allExerciseIds = allExercises.map { $0.id }
        let allRecords = historyRepository.get().map({ $0.records }).flatMap({ $0 })
        
        for record in allRecords {
            if allExerciseIds.contains(record.exerciseId) {
                result[record.exerciseId, default: 0] += 1
            }
        }
        
        guard let maxValue = result.values.max() else { return [:] }
        
        for (key, value) in result {
            result[key] = value / maxValue
        }
        
        return result
    }
}
