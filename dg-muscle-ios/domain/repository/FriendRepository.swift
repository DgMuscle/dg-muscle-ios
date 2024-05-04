//
//  FriendRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

protocol FriendRepository {
    var friends: [UserDomain] { get }
    var friendsPublisher: AnyPublisher<[UserDomain], Never> { get }
}
