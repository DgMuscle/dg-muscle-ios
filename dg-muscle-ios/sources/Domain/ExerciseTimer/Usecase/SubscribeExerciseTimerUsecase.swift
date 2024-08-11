//
//  SubscribeExerciseTimerUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Combine

public final class SubscribeExerciseTimerUsecase {
    private let exerciseTimerRepository: ExerciseTimerRepository
    @Published var timer: ExerciseTimerDomain?
    
    public init(exerciseTimerRepository: ExerciseTimerRepository) {
        self.exerciseTimerRepository = exerciseTimerRepository
        bind()
    }
    
    public func implement() -> AnyPublisher<ExerciseTimerDomain?, Never> {
        $timer.eraseToAnyPublisher()
    }
    
    private func bind() {
        exerciseTimerRepository
            .timer
            .map({ timer -> ExerciseTimerDomain? in
                var timer = timer
                
                if let exist = timer {
                    if exist.targetDate < Date() {
                        timer = nil
                    }
                }
                
                return timer
            })
            .assign(to: &$timer)
    }
}
