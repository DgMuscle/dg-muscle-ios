//
//  PageAnchorViewModel.swift
//  Friend
//
//  Created by 신동규 on 6/9/24.
//

import Foundation
import Combine
import Domain

final class PageAnchorViewModel: ObservableObject {
    
    @Published var hasRequest: Bool = false
    
    private let subscribeFriendRequestsUsecase: SubscribeFriendRequestsUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: FriendRepository
    ) {
        subscribeFriendRequestsUsecase = .init(friendRepository: friendRepository)
        bind()
    }
    
    private func bind() {
        subscribeFriendRequestsUsecase
            .implement()
            .map({ $0.isEmpty })
            .map({ !$0 })
            .receive(on: DispatchQueue.main)
            .assign(to: \.hasRequest, on: self)
            .store(in: &cancellables)
    }
}
