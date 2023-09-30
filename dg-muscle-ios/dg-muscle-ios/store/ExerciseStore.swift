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
    
    @Published private(set) var exercises: [Exercise] = []
    
    private var updateExercisesTask: Task<(), Error>?
    
    private init() { }
    
    func updateExercises() {
        guard updateExercisesTask == nil else { return }
        updateExercisesTask = Task {
            let exercises = try await ExerciseRepository.shared.get()
            
            DispatchQueue.main.async {
                self.exercises = exercises.sorted(by: { $0.order < $1.order })
            }
            updateExercisesTask = nil
        }
    }
}
