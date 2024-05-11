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
    var requests: [FriendRequestDomain] { get }
    var requestsPublisher: AnyPublisher<[FriendRequestDomain], Never> { get }
    
    func postRequest(userId: String) async throws
    func updateRequests()
    func updateFriends()
    func accept(request: FriendRequestDomain) async throws
    func refuse(request: FriendRequestDomain) async throws
    func get(uid: String) async throws -> [ExerciseDomain]
}
