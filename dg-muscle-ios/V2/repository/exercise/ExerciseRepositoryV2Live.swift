//
//  ExerciseRepositoryV2Live.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

final class ExerciseRepositoryV2Live: ExerciseRepositoryV2 {
    static let shared = ExerciseRepositoryV2Live()
    
    var exercises: [Exercise] {
        _exercises
    }
    
    var exercisesPublisher: AnyPublisher<[Exercise], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published private var _exercises: [Exercise] = []
    
    private init() {
        _exercises = fetchExerciseDataFromFile()
        
        Task {
            _exercises = try await fetchExerciseDataFromServer()
        }
    }
    
    private func fetchExerciseDataFromFile() -> [Exercise] {
        (try? FileManagerHelper.load([Exercise].self, fromFile: .exercise)) ?? []
    }
    
    private func fetchExerciseDataFromServer() async throws -> [Exercise] {
        var exercises: [Exercise] = try await APIClient.shared.request(url: "https://exercise-getexercises-kpjvgnqz6a-uc.a.run.app")
        exercises = exercises.sorted(by: { $0.order < $1.order })
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return exercises
    }
}
