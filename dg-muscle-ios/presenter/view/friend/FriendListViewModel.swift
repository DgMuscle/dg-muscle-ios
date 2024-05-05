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
    
    private let getMyFriendsUsecase: GetMyFriendsUsecase
    private let subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase
    private var cancellables = Set<AnyCancellable>()
    init(getMyFriendsUsecase: GetMyFriendsUsecase,
         subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase) {
        self.getMyFriendsUsecase = getMyFriendsUsecase
        self.subscribeFriendRequestsUsecase = subscribeFriendRequestsUsecase
        friends = getMyFriendsUsecase.implement().map({ .init(from: $0) })
        
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
    }
}
