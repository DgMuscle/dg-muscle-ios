//
//  SettingViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation
import Combine

final class SettingViewModel: ObservableObject {
    @Published var user: UserV?
    @Published var errorMessage: String?
    
    let subscribeUserUsecase: SubscribeUserUsecase
    let signOutUsecase: SignOutUsecase
    let deleteAccountUsecase: DeleteAccountUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(subscribeUserUsecase: SubscribeUserUsecase,
         signOutUsecase: SignOutUsecase,
         deleteAccountUsecase: DeleteAccountUsecase) {
        self.subscribeUserUsecase = subscribeUserUsecase
        self.signOutUsecase = signOutUsecase
        self.deleteAccountUsecase = deleteAccountUsecase
        bind()
    }
    
    func signOut() {
        do {
            errorMessage = nil
            try signOutUsecase.implement()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() {
        Task {
            do {
                errorMessage = nil
                try await deleteAccountUsecase.implement()
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
                    self?.user = .init(from: user)
                } else {
                    self?.user = nil
                }
            }
            .store(in: &cancellables)
    }
}
