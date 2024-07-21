//
//  SubscribeRapidAllExercisesUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine

public final class SubscribeRapidAllExercisesUsecase {
    private let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement() -> AnyPublisher<[RapidExerciseDomain], Never> {
        rapidRepository.exercises
    }
}
