//
//  MyViewModel.swift
//  My
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain
import Combine
import Common

final class MyViewModel: ObservableObject {
    @Published var user: Common.User? = nil
    @Published var errorMessage: String? = nil
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    private let signOutUsecase: SignOutUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: any UserRepository) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        signOutUsecase = .init(userRepository: userRepository)
        bind()
    }
    
    @MainActor
    func signOut() {
        Task {
            do {
                errorMessage = nil
                try signOutUsecase.implement()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
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
