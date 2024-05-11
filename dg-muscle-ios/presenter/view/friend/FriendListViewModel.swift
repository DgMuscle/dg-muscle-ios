//
//  FriendListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class FriendListViewModel: ObservableObject {
    @Published var friends: [UserV] = [] 
    @Published var hasRequest: Bool = false
    
    private let subscribeMyFriendsUsecase: SubscribeMyFriendsUsecase
    private let subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase
    private var cancellables = Set<AnyCancellable>()
    init(subscribeMyFriendsUsecase: SubscribeMyFriendsUsecase,
         subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase) {
        self.subscribeMyFriendsUsecase = subscribeMyFriendsUsecase
        self.subscribeFriendRequestsUsecase = subscribeFriendRequestsUsecase
        
        bind()
    }
    
    private func bind() {
        subscribeFriendRequestsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] requests in
                guard let self else { return }
                hasRequest = !requests.isEmpty
            }
            .store(in: &cancellables)
        
        subscribeMyFriendsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] friends in
                self?.friends = friends.map({ .init(from: $0) })
            }
            .store(in: &cancellables)
    }
}
