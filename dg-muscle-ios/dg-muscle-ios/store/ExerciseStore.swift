//
//  ExerciseStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import Combine
import Foundation

final class ExerciseStore: ObservableObject {
    static let shared = ExerciseStore()
    
    @Published private(set) var exercises: [Exercise] = ExerciseRepository.shared.getCache()
    
    private init() { }
    
    func append(exercise: Exercise) {
        var exercises = exercises
        exercises.append(exercise)
        exercises = exercises.sorted(by: { $0.order < $1.order })
        self.exercises = exercises
    }
    
    func set(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    func updateExercises() {
        Task {
            let exercises = try await ExerciseRepository.shared.get()
            
            DispatchQueue.main.async {
                self.exercises = exercises.sorted(by: { $0.order < $1.order })
            }
            
            try ExerciseRepository.shared.saveCache(exercises: exercises)
        }
    }
}
