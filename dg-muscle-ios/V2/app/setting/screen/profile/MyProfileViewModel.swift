//
//  MyProfileViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import Foundation
import Combine

final class MyProfileViewModel: ObservableObject {
    @Published var user: DGUser?
    
    let userRepository: UserRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2) {
        self.userRepository = userRepository
        bind()
    }
    
    private func bind() {
        userRepository.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
