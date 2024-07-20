//
//  ExerciseListViewModel.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import Foundation
import Combine
import Domain
import Common

final class ExerciseListViewModel: ObservableObject {
    
    @Published var exerciseSections: [ExerciseSection] = []
    @Published var status: Common.StatusView.Status? = nil
    @Published var deletedExercises: [Exercise] = []
    
    private let subscribeExercisesGroupedByPartUsecase: SubscribeExercisesGroupedByPartUsecase
    private let deleteExerciseUsecase: DeleteExerciseUsecase
    private let postExerciseUsecase: PostExerciseUsecase
    private let getExercisePopularityUsecase: GetExercisePopularityUsecase
    
    init(
        exerciseRepository: any ExerciseRepository,
        historyRepository: any HistoryRepository
    ) {
        subscribeExercisesGroupedByPartUsecase = .init(exerciseRepository: exerciseRepository)
        deleteExerciseUsecase = .init(exerciseRepository: exerciseRepository)
        postExerciseUsecase = .init(exerciseRepository: exerciseRepository)
        getExercisePopularityUsecase = .init(
            exerciseRepository: exerciseRepository,
            historyRepository: historyRepository
        )
        bind()
    }
    
    @MainActor
    func delete(part: Exercise.Part, indexSet: IndexSet) {
        Task {
            guard let index = exerciseSections.firstIndex(where: { $0.part == part }) else { return }
            
            let section = exerciseSections[index]
            let exercises = section.exercises
            var exercisesToDelete: [Exercise] = []
            
            for index in indexSet {
                exercisesToDelete.append(exercises[index])
            }
            
            deletedExercises.append(contentsOf: exercisesToDelete)
            
            exerciseSections[index].exercises.remove(atOffsets: indexSet)
            
            for exercise in exercisesToDelete {
                try await deleteExerciseUsecase.implement(exercise: exercise.domain)
            }
        }
    }
    
    @MainActor
    func rollBack(_ exercise: Exercise) {
        Task {
            guard let index = deletedExercises.firstIndex(where: { $0.id == exercise.id }) else { return }
            deletedExercises.remove(at: index)
            try await postExerciseUsecase.implement(exercise: exercise.domain)
        }
    }
    
    private func bind() {
        subscribeExercisesGroupedByPartUsecase
            .implement()
            .compactMap({ [weak self] in self?.getExerciseSections(from: $0) })
            .receive(on: DispatchQueue.main)
            .assign(to: &$exerciseSections)
    }
    
    private func getExerciseSections(from group: [Domain.Exercise.Part: [Domain.Exercise]]) -> [ExerciseSection] {
        var exerciseSections: [ExerciseSection] = []
        
        for (part, exercises) in group {
            
            let part: Exercise.Part = .init(domain: part)
            var exercises: [Exercise] = exercises
                .map({ .init(domain: $0) })
                .sorted(by: { $0.name < $1.name })
            
            let exercisePopularities = getExercisePopularityUsecase.implement()
            
            for (exerciseId, popularity) in exercisePopularities {
                if let index = exercises.firstIndex(where: { $0.id == exerciseId }) {
                    exercises[index].popularity = popularity
                }
            }
            
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
