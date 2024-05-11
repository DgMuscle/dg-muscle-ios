//
//  GetFriendExercisesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation

final class GetFriendExercisesUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(friendId: String) async throws -> [ExerciseDomain] {
        try await friendRepository.get(uid: friendId)
    }
}
