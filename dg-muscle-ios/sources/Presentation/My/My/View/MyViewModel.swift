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
    @Published var loading: Bool = false
    @Published var hasLogBadge: Bool = false
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    private let signOutUsecase: SignOutUsecase
    private let subscribeDeleteAccountTriggerUsecase: SubscribeDeleteAccountTriggerUsecase
    private let deleteAccountUsecase: DeleteAccountUsecase
    private let subscribeLogBadgeUsecase: SubscribeLogBadgeUsecase
    
    private var deleteAccountTask: Task<(), Never>?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        userRepository: any UserRepository,
        logRepository: LogRepository
    ) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        signOutUsecase = .init(userRepository: userRepository)
        subscribeDeleteAccountTriggerUsecase = .init(userRepository: userRepository)
        deleteAccountUsecase = .init(userRepository: userRepository)
        subscribeLogBadgeUsecase = .init(logRepository: logRepository)
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
        
        subscribeDeleteAccountTriggerUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.deleteAccount()
            }
            .store(in: &cancellables)
        
        subscribeLogBadgeUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hasBadge in
                self?.hasLogBadge = hasBadge
            }
            .store(in: &cancellables)
    }
    
    private func deleteAccount() {
        Task {
            await deleteAccountMainActor()
        }
    }
    
    @MainActor
    private func deleteAccountMainActor() {
        guard deleteAccountTask == nil else { return }
        deleteAccountTask = Task {
            loading = true
            let error = await deleteAccountUsecase.implement()
            self.errorMessage = error?.localizedDescription
            loading = false
            deleteAccountTask = nil
        }
    }
}
