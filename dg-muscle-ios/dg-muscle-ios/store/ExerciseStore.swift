//
//  ExerciseStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import Combine
import Foundation
import SwiftUI

final class ExerciseStore: ObservableObject {
    static let shared = ExerciseStore()
    
    @Published private(set) var exercises: [Exercise] = ExerciseRepository.shared.getCache()
    @Published private(set) var exerciseSections: [ExerciseSection] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private init() {
        
        setSections(exercises: self.exercises)
        
        $exercises
            .sink { exercises in
                self.setSections(exercises: exercises)
            }
            .store(in: &cancellables)
    }
    
    func update(exercise: Exercise) {
        var exercises = exercises
        
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
        } else {
            exercises.append(exercise)
        }
        
        exercises = exercises.sorted(by: { $0.order < $1.order })
        DispatchQueue.main.async {
            withAnimation {
                self.exercises = exercises
            }
        }
    }
    
    func set(exercises: [Exercise]) {
        let exercises = exercises.sorted(by: { $0.order < $1.order })
        DispatchQueue.main.async {
            withAnimation {
                self.exercises = exercises
            }
        }
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
    
    private func setSections(exercises: [Exercise]) {
        var dictionary: [Exercise.Part: [Exercise]] = [:]
        exercises.forEach { exercise in
            exercise.parts.forEach { part in
                if dictionary[part] == nil {
                    dictionary[part] = [exercise]
                } else {
                    dictionary[part]?.append(exercise)
                }
            }
        }
        
        let section = dictionary.map { ExerciseSection(part: $0, exercises: $1) }.sorted(by: { $0.part < $1.part })
        
        DispatchQueue.main.async {
            self.exerciseSections = section
        }
    }
}
