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
    let subscribeUserUsecase: SubscribeUserUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(subscribeUserUsecase: SubscribeUserUsecase) {
        self.subscribeUserUsecase = subscribeUserUsecase
        bind()
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
