//
//  FriendRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import Foundation
import Combine

protocol FriendRepository {
    var friends: [Friend] { _friends }
    var friendsPublisher: AnyPublisher<[Friend], Never>
    
    func fetchFriends()
}
