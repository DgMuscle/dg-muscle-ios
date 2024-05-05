//
//  GetUserFromUserIdUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

final class GetUserFromUserIdUsecase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement(uid: String) async throws -> UserDomain {
        try await userRepository.get(id: uid)
    }
}
