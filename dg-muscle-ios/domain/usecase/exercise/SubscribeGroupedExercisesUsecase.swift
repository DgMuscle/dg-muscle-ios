//
//  SubscribeGroupedExercisesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

// 운동을 이름별로 묶어서 반환
final class SubscribeGroupedExercisesUsecase {
    private let exerciseRepository: ExerciseRepository
    
    @Published private var exercises: [ExerciseDomain] = []
    @Published private var grouped: [ExerciseDomain.Part: [ExerciseDomain]] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
        bind()
    }
    
    func implement() -> AnyPublisher<[ExerciseDomain.Part: [ExerciseDomain]], Never> {
        $grouped.eraseToAnyPublisher()
    }
    
    private func bind() {
        exerciseRepository.exercisesPublisher
            .sink { [weak self] exercises in
                self?.exercises = exercises
            }
            .store(in: &cancellables)
        
        $exercises
            .sink { [weak self] exercises in
                self?.group(exercises: exercises)
            }
            .store(in: &cancellables)
    }
    
    private func group(exercises: [ExerciseDomain]) {
        var grouped: [ExerciseDomain.Part: [ExerciseDomain]] = [:]
        
        for exercise in exercises {
            for part in exercise.parts {
                if grouped[part, default: []].contains(where: { $0.id == exercise.id }) == false {
                    grouped[part, default: []].append(exercise)
                }
            }
        }
        
        for (key, value) in grouped {
            grouped[key] = value.sorted(by: { $0.name < $1.name })
        }
        
        self.grouped = grouped
    }
}
