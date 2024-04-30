//
//  GetIsLoginUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class GetIsLoginUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement() -> Bool {
        userRepository.isLogin
    }
}
