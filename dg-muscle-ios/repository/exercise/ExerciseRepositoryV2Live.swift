//
//  ExerciseRepositoryV2Live.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation

final class ExerciseRepositoryV2Live: ExerciseRepositoryV2 {
    static let shared = ExerciseRepositoryV2Live()
    
    var exercises: [Exercise] {
        _exercises
    }
    
    var exercisesPublisher: AnyPublisher<[Exercise], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published private var _exercises: [Exercise] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        _exercises = fetchExerciseDataFromFile()
        
        Task {
            _exercises = try await fetchExerciseDataFromServer()
        }
        
        bind()
    }
    
    private func bind() {
        UserRepositoryV2Live.shared
            .isLoginPublisher
            .dropFirst()
            .removeDuplicates()
            .sink { login in
                if login {
                    
                    DispatchQueue.main.async {
                        Task {
                            self._exercises = try await self.fetchExerciseDataFromServer()
                        }
                    }
                    
                } else {
                    self._exercises = []
                }
            }
            .store(in: &cancellables)
    }
    
    func post(data: Exercise) async throws -> DefaultResponse {
        _exercises.append(data)
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return try await APIClient.shared.request(method: .post, url: FunctionsURL.exercise(.postexercise), body: data)
    }
    
    func edit(data: Exercise) async throws -> DefaultResponse {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises[index] = data
        } else {
            throw CustomError.index
        }
        
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return try await APIClient.shared.request(method: .post, url: FunctionsURL.exercise(.postexercise), body: data)
    }
    
    func delete(data: Exercise) async throws -> DefaultResponse {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises.remove(at: index)
        } else {
            throw CustomError.index
        }
        
        try FileManagerHelper.save(exercises, toFile: .exercise)
        
        struct Body: Codable {
            let id: String
        }
        
        let body = Body(id: data.id)
        
        return try await APIClient.shared.request(method: .delete,
                                                    url: FunctionsURL.exercise(.deleteexercise),
                                                    body: body,
                                                    additionalHeaders: nil)
    }
    
    func get(exerciseId: String) -> Exercise? {
        exercises.first(where: { $0.id == exerciseId })
    }
    
    private func fetchExerciseDataFromFile() -> [Exercise] {
        (try? FileManagerHelper.load([Exercise].self, fromFile: .exercise)) ?? []
    }
    
    private func fetchExerciseDataFromServer() async throws -> [Exercise] {
        var exercises: [Exercise] = try await APIClient.shared.request(url: FunctionsURL.exercise(.getexercises))
        exercises = exercises.sorted(by: { $0.order < $1.order })
        try FileManagerHelper.save(exercises, toFile: .exercise)
        return exercises
    }
}
