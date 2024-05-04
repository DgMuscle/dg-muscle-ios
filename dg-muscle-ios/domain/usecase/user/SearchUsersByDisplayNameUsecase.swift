//
//  SearchUsersByDisplayNameUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

final class SearchUsersByDisplayNameUsecase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement(displayName: String) -> [UserDomain] {
        var users = userRepository.users
        let searchQuery = displayName.filter({ !$0.isWhitespace }).lowercased()
        
        users = users.filter({
            guard var displayName = $0.displayName else { return false }
            displayName = displayName.filter({ !$0.isWhitespace }).lowercased()
            return displayName.contains(searchQuery)
        })
        
        return users
    }
}
