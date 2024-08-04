//
//  FriendMainViewModel.swift
//  Friend
//
//  Created by 신동규 on 7/29/24.
//

import Foundation
import Combine
import Domain

final class FriendMainViewModel: ObservableObject {
    @Published var loading: Bool = true
    
    let subscribeFetchingFriendLoadingUsecase: SubscribeFetchingFriendLoadingUsecase
    
    init(friendRepository: FriendRepository) {
        subscribeFetchingFriendLoadingUsecase = .init(friendRepository: friendRepository)
        bind()
    }
    
    private func bind() {
        subscribeFetchingFriendLoadingUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .assign(to: &$loading)
    }
}
