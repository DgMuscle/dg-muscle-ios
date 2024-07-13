//
//  SubscribeOnlyShowsFavoriteExercisesUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Combine

public final class SubscribeOnlyShowsFavoriteExercisesUsecase {
    @Published var onlyShowsFavoriteExercises: Bool
    
    let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.onlyShowsFavoriteExercises = userRepository.get()?.onlyShowsFavoriteExercises ?? false
        self.userRepository = userRepository
        
        bind()
    }
    
    public func implement() -> AnyPublisher<Bool, Never> {
        $onlyShowsFavoriteExercises.eraseToAnyPublisher()
    }
    
    private func bind() {
        userRepository
            .user
            .map({ $0?.onlyShowsFavoriteExercises ?? false })
            .assign(to: &$onlyShowsFavoriteExercises)
    }
}
