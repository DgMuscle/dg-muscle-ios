//
//  MyViewModel.swift
//  My
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain
import Combine

final class MyViewModel: ObservableObject {
    @Published var user: User? = nil
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: any UserRepository) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeUserUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                if let user {
                    self?.user = .init(domain: user)
                } else {
                    self?.user = nil
                }
            }
            .store(in: &cancellables)
    }
}
