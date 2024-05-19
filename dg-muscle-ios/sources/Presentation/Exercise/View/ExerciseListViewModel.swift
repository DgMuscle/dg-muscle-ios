//
//  ExerciseListViewModel.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import Foundation
import Combine
import Domain

final class ExerciseListViewModel: ObservableObject {
    
    @Published var exerciseSections: [ExerciseSection] = []
    
    private let subscribeExercisesGroupedByPartUsecase: SubscribeExercisesGroupedByPartUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        exerciseRepository: any ExerciseRepository
    ) {
        subscribeExercisesGroupedByPartUsecase = .init(exerciseRepository: exerciseRepository)
        bind()
    }
    
    private func bind() {
        subscribeExercisesGroupedByPartUsecase
            .implement()
            .compactMap({ [weak self] in self?.getExerciseSections(from: $0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.exerciseSections, on: self)
            .store(in: &cancellables)
    }
    
    private func getExerciseSections(from group: [Domain.Exercise.Part: [Domain.Exercise]]) -> [ExerciseSection] {
        var exerciseSections: [ExerciseSection] = []
        
        for (part, exercises) in group {
            
            let part: Exercise.Part = .init(domain: part)
            let exercises: [Exercise] = exercises
                .map({ .init(domain: $0) })
                .sorted(by: { $0.name < $1.name })
            
            let section: ExerciseSection = .init(
                part: part,
                exercises: exercises
            )
            
            exerciseSections.append(section)
        }
        
        exerciseSections = exerciseSections.sorted(by: { $0.part.rawValue < $1.part.rawValue })
        
        return exerciseSections
    }
}
