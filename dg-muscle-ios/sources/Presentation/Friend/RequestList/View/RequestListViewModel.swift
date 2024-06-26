//
//  RequestListViewModel.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Combine
import Domain
import Common
import SwiftUI

class RequestListViewModel: ObservableObject {
    @Published var requests: [FriendRequest] = []
    let color: Color
    private let getUserFromUidUsecase: GetUserFromUidUsecase
    private let subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase
    private let refuseFriendUsecase: RefuseFriendUsecase
    private let acceptFriendUsecase: AcceptFriendUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(friendRepository: FriendRepository, userRepository: UserRepository) {
        getUserFromUidUsecase = .init(friendRepository: friendRepository)
        subscribeFriendRequestsUsecase = .init(friendRepository: friendRepository)
        refuseFriendUsecase = .init(friendRepository: friendRepository)
        acceptFriendUsecase = .init(friendRepository: friendRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        
        let heatMapColor: Common.HeatMapColor = .init(domain: getHeatMapColorUsecase.implement())
        self.color = heatMapColor.color
        
        bind()
    }
    
    func accept(request: FriendRequest) {
        Task {
            try await acceptFriendUsecase.implement(request: request.domain)
        }
    }
    
    func refuse(request: FriendRequest) {
        Task {
            try await refuseFriendUsecase.implement(request: request.domain)
        }
    }
    
    private func bind() {
        subscribeFriendRequestsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .compactMap({ [weak self] requests in
                guard let self else { return [] }
                
                var friendRequests: [FriendRequest] = []
                
                for request in requests {
                    if let user = getUserFromUidUsecase.implement(uid: request.fromId) {
                        friendRequests.append(.init(user: .init(domain: user), createdAt: request.createdAt))
                    }
                }
                
                return friendRequests
            })
            .assign(to: &$requests)
    }
}
