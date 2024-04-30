//
//  ContentViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var isLogin: Bool
    
    let subscribeIsLoginUsecase: SubscribeIsLoginUsecase
    let getIsLoginUsecase: GetIsLoginUsecase
    
    private var cancellables = Set<AnyCancellable>()
    init(
        subscribeIsLoginUsecase: SubscribeIsLoginUsecase,
        getIsLoginUsecase: GetIsLoginUsecase
    ) {
        self.subscribeIsLoginUsecase = subscribeIsLoginUsecase
        self.getIsLoginUsecase = getIsLoginUsecase
        isLogin = getIsLoginUsecase.implement()
        bind()
    }
    
    private func bind() {
        subscribeIsLoginUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] isLogin in
                self?.isLogin = isLogin
            }
            .store(in: &cancellables)
    }
}
