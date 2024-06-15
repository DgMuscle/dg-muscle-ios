//
//  PostLinkUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/9/24.
//

import UIKit

public final class PostLinkUsecase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement(link: URL?) {
        userRepository.updateUser(link: link)
    }
}
