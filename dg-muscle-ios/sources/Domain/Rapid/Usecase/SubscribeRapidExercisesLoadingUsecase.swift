//
//  SubscribeRapidExercisesLoadingUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/22/24.
//

import Foundation
import Combine

public final class SubscribeRapidExercisesLoadingUsecase {
    let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement() -> AnyPublisher<Bool, Never> {
        rapidRepository.exercisesLoading
    }
}
