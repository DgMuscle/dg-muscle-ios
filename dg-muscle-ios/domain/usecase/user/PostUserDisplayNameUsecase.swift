//
//  PostUserDisplayNameUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class PostUserDisplayNameUsecase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement(name: String?) {
        Task {
            var name = name
            if name?.isEmpty == true {
                name = nil
            }
            try await userRepository.updateUser(displayName: name)
        }
    }
}
