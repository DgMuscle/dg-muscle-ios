//
//  GetFriendExercisesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation

final class GetFriendExercisesUsecase {
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(friendId: String) async throws -> [ExerciseDomain] {
        try await exerciseRepository.get(uid: friendId)
    }
}
