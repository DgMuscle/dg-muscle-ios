//
//  SubscribeFriendRequestsUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class SubscribeFriendRequestsUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement() -> AnyPublisher<[FriendRequestDomain], Never> {
        friendRepository.requestsPublisher
    }
}
