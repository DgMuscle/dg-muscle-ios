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
    @Published var splash: Bool = true
    
    @Published var defaultSplashTimePassed: Bool = false
    
    private let subscribeUserUsecase: SubscribeUserUsecase
    private let subscribeIsAppReadyUseCase: SubscribeIsAppReadyUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        subscribeUserUsecase = .init(userRepository: userRepository)
        subscribeIsAppReadyUseCase = .init(userRepository: userRepository)
        bind()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            self?.defaultSplashTimePassed = true
        }
    }
    
    private func bind() {
        subscribeUserUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .map({ $0 != nil })
            .assign(to: &$isLogin)
        
        $defaultSplashTimePassed
            .removeDuplicates()
            .combineLatest(subscribeIsAppReadyUseCase.implement().removeDuplicates())
            .receive(on: DispatchQueue.main)
            .map({ $0 && $1 })
            .map({ !$0 })
            .assign(to: &$splash)
    }
}
