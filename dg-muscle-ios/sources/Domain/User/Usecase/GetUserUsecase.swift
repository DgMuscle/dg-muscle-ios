//
//  GetUserUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation

public final class GetUserUsecase {
    private let userRepository: UserRepository
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    public func implement() -> User? {
        userRepository.get()
    }
}
