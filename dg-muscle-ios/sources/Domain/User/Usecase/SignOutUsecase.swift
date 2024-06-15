//
//  SignOutUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/19/24.
//

import Foundation

public final class SignOutUsecase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() throws {
        try userRepository.signOut()
    }
}
