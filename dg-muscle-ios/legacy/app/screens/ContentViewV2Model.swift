//
//  ContentViewV2Model.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/17/24.
//

import Foundation
import Combine

final class ContentViewV2Model: ObservableObject {
    @Published private(set) var isLogin: Bool = false
    
    let userRepository: UserRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2) {
        self.userRepository = userRepository
        bind()
    }
    
    private func bind() {
        userRepository
            .userPublisher
            .sink { [weak self] user in
                self?.isLogin = user != nil
            }
            .store(in: &cancellables)
    }
}
