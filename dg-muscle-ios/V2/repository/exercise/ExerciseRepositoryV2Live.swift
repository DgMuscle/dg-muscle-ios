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
    
    func post(data: Exercise) async throws -> DefaultResponse {
        _exercises.append(data)
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return try await APIClient.shared.request(method: .post, url: "https://exercise-postexercise-kpjvgnqz6a-uc.a.run.app", body: data)
    }
    
    func edit(data: Exercise) async throws -> DefaultResponse {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises[index] = data
        } else {
            throw CustomError.index
        }
        
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return try await APIClient.shared.request(method: .post, url: "https://exercise-setexercises-kpjvgnqz6a-uc.a.run.app", body: exercises)
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
