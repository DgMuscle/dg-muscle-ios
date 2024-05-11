//
//  SubscribeMyFriendsUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation
import Combine

final class SubscribeMyFriendsUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement() -> AnyPublisher<[UserDomain], Never> {
        friendRepository.friendsPublisher
    }
}
