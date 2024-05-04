//
//  FriendRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class FriendRepositoryData: FriendRepository {
    var friends: [UserDomain] { _friends }
    var friendsPublisher: AnyPublisher<[UserDomain], Never> { $_friends.eraseToAnyPublisher() }
    @Published private var _friends: [UserDomain] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        bind()
    }
    
    func postRequest(userId: String) async throws {
        let _: ResponseData = try await APIClient.shared.request(method: .post,
                                           url: FunctionsURL.friend(.postrequest))
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
                } else {
                    self._friends = []
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
