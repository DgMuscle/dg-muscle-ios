//
//  FriendRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class FriendRepositoryData: FriendRepository {
    static let shared = FriendRepositoryData()
    var friends: [UserDomain] { _friends }
    var friendsPublisher: AnyPublisher<[UserDomain], Never> { $_friends.eraseToAnyPublisher() }
    @Published private var _friends: [UserDomain] = []
    
    var requests: [FriendRequestDomain] { _requests }
    var requestsPublisher: AnyPublisher<[FriendRequestDomain], Never> { $_requests.eraseToAnyPublisher() }
    @Published private var _requests: [FriendRequestDomain] = []
    
    private var exercises: [String: [ExerciseDomain]] = [:]
    private var histories: [String: [HistoryDomain]] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        bind()
    }
    
    func postRequest(userId: String) async throws {
        struct Body: Codable {
            let toId: String
        }
        
        let body = Body(toId: userId)
        
        let _: ResponseData = try await APIClient.shared.request(method: .post,
                                                                 url: FunctionsURL.friend(.postrequest),
                                                                 body: body)
    }
    
    func updateRequests() {
        Task {
            let data: [FriendRequestData] = try await APIClient.shared.request(method: .get,
                                                                               url: FunctionsURL.friend(.getrequests))
            
            self._requests = data.map({ $0.domain })
        }
    }
    
    func accept(request: FriendRequestDomain) async throws {
        struct Body: Codable {
            let friendId: String
        }
        
        if let index = self.requests.firstIndex(where: { $0.fromId == request.fromId }) {
            self._requests.remove(at: index)
        }
        
        let _: ResponseData = try await APIClient.shared.request(method: .post,
                                                                 url: FunctionsURL.friend(.post),
                                                                 body: Body(friendId: request.fromId))
    }
    
    func refuse(request: FriendRequestDomain) async throws {
        struct Body: Codable {
            let deleteId: String
        }
        
        if let index = self.requests.firstIndex(where: { $0.fromId == request.fromId }) {
            self._requests.remove(at: index)
        }
        
        let _: ResponseData = try await APIClient.shared.request(method: .delete,
                                                                 url: FunctionsURL.friend(.deleterequest),
                                                                 body: Body(deleteId: request.fromId))
    }
    
    func get(uid: String) async throws -> [ExerciseDomain] {
        if let exercises = self.exercises[uid] {
            return exercises
        }
        
        let exercises = try await ExerciseRepositoryData.shared.get(uid: uid)
        self.exercises[uid] = exercises
        return exercises
    }
    
    func get(uid: String) async throws -> [HistoryDomain] {
        if let histories = self.histories[uid] {
            return histories
        }
        
        let histories = try await HistoryRepositoryData.shared.get(uid: uid)
        self.histories[uid] = histories
        return histories
    }
    
    func appendFriend(uid: String) {
        if let user = UserRepositoryData.shared.users.first(where: { $0.uid == uid }) {
            self._friends.append(user)
        }
    }
    
    private func bind() {
        UserRepositoryData
            .shared
            .isLoginPublisher.filter({ $0 })
            .combineLatest(UserRepositoryData.shared.usersPublisher)
            .receive(on: DispatchQueue.main)
            .sink { isLogin, users in
                Task {
                    if isLogin {
                        let friends = try await self.getFriendsFromServer(users: users)
                        self._friends = friends
                        self.updateRequests()
                    } else {
                        self._friends = []
                        self._requests = []
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func getFriendsFromServer(users: [UserDomain]) async throws -> [UserDomain] {
        let data: [FriendData] = try await APIClient.shared.request(method: .get, url: FunctionsURL.friend(.getfriends))
        let ids: [String] = data.map({ $0.uid })
        var friends = users
        friends = friends.filter({ ids.contains($0.uid) })
        return friends
    }
}
