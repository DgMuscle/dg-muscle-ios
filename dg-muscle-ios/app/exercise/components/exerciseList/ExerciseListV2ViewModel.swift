//
//  ExerciseListV2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Foundation
import Combine

final class ExerciseListV2ViewModel: ObservableObject {
    
    struct ExerciseSection: Hashable {
        let part: Exercise.Part
        let exercises: [Exercise]
    }
    
    @Published private(set) var sections: [ExerciseSection] = []
    @Published private var exercisesHashMap: [Exercise.Part: [Exercise]] = [:]
    
    private let exerciseRepository: ExerciseRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(exerciseRepository: ExerciseRepositoryV2) {
        self.exerciseRepository = exerciseRepository
        bind()
    }
    
    private func bind() {
        exerciseRepository.exercisesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exercises in
                guard let self else { return }
                exercisesHashMap = getExercisesHashMap(exercises: exercises)
            }
            .store(in: &cancellables)
        
        $exercisesHashMap
            .sink { [weak self] hashMap in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.sections = self.getSections(exercisesHashMap: hashMap)
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func getExercisesHashMap(exercises: [Exercise]) -> [Exercise.Part: [Exercise]] {
        var exerciseSection: [Exercise.Part: [Exercise]] = [:]
        
        for exercise in exercises {
            let parts = exercise.parts
            
            for part in parts {
                exerciseSection[part, default: []].append(exercise)
            }
        }
        
        return exerciseSection
    }
    
    private func getSections(exercisesHashMap: [Exercise.Part: [Exercise]]) -> [ExerciseSection] {
        var result: [ExerciseSection] = []
        
        for (part, exercises) in exercisesHashMap {
            result.append(.init(part: part, exercises: exercises))
        }
        
        result = result.sorted(by: { $0.part < $1.part })
        
        return result
    }
}
