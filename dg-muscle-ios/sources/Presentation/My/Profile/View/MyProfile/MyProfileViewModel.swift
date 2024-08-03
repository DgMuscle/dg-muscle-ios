//
//  MyProfileViewModel.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Combine
import Common
import Domain

final class MyProfileViewModel: ObservableObject {
    
    @Published var user: Common.User?
    @Published var isEditing: Bool = false
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    
    init(
        userRepository: UserRepository
    ) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        bind()
    }
    
    private func bind() {
        subscribeUserUsecase
            .implement()
            .compactMap({ $0 })
            .map({ Common.User(domain: $0) })
            .receive(on: DispatchQueue.main)
            .assign(to: &$user)
    }
}
