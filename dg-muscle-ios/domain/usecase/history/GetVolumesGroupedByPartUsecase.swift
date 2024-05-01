//
//  GetVolumesGroupedByPartUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class GetVolumesGroupedByPartUsecase {
    
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(history: HistoryDomain) -> [ExerciseDomain.Part: Double] {
        let exercises = exerciseRepository.exercises
        var map: [ExerciseDomain.Part: Double] = [:]
        
        for part in ExerciseDomain.Part.allCases {
            map[part] = 0
        }
        
        for record in history.records {
            if let exercise = exercises.first(where: { $0.id == record.exerciseId }) {
                for part in exercise.parts {
                    map[part, default: 0] += record.volume
                }
            }
        }
        
        return map
    }
}
