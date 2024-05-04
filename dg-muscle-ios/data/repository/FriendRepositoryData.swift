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
        // TODO: Update friend requests when push notification arrived
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
        
        let _: ResponseData = try await APIClient.shared.request(method: .post,
                                                                 url: FunctionsURL.friend(.post),
                                                                 body: Body(friendId: request.fromId))
    }
    
    func refuse(request: FriendRequestDomain) async throws {
        struct Body: Codable {
            let deleteId: String
        }
        
        let _: ResponseData = try await APIClient.shared.request(method: .delete,
                                                                 url: FunctionsURL.friend(.deleterequest),
                                                                 body: Body(deleteId: request.fromId))
    }
    
    private func bind() {
        UserRepositoryData
            .shared
            .isLoginPublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { isLogin in
                if isLogin {
                    Task {
                        self._friends = try await self.getFriendsFromServer()
                    }
                    
                    self.updateRequests()
                } else {
                    self._friends = []
                    self._requests = []
                }
            }
            .store(in: &cancellables)
    }
    
    private func getFriendsFromServer() async throws -> [UserDomain] {
        let data: [UserData] = try await APIClient.shared.request(method: .get, url: FunctionsURL.friend(.getfriends))
        let friends: [UserDomain] = data.map({ $0.domain })
        return friends
    }
}
