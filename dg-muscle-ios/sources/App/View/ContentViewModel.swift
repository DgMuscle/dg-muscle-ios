//
//  ContentViewModel.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import Foundation
import Combine
import Domain

final class ContentViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        bind()
    }
    
    private func bind() {
        subscribeUserUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.isLogin = user != nil
            }
            .store(in: &cancellables)
    }
}
