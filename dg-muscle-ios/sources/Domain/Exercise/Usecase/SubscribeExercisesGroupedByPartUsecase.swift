//
//  SubscribeExercisesGroupedByPartUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/19/24.
//

import Foundation
import Combine

public final class SubscribeExercisesGroupedByPartUsecase {
    @Published var data: [Exercise.Part: [Exercise]] = [:]
    
    private let exerciseRepository: ExerciseRepository
    private var cancellables = Set<AnyCancellable>()
    public init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
        bind()
    }
    
    public func implement() -> AnyPublisher<[Exercise.Part: [Exercise]], Never> {
        $data.eraseToAnyPublisher()
    }
    
    private func bind() {
        exerciseRepository
            .exercises
            .map({ GroupExercisesByPartUsecase().implement(exercises: $0) })
            .assign(to: \.data, on: self)
            .store(in: &cancellables)
    }
}
