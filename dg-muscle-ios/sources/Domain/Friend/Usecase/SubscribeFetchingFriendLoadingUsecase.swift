//
//  SubscribeFetchingFriendLoadingUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/29/24.
//

import Foundation
import Combine

public final class SubscribeFetchingFriendLoadingUsecase {
    let friendRepository: FriendRepository
    
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    public func implement() -> AnyPublisher<Bool, Never> {
        friendRepository.loading
    }
}
