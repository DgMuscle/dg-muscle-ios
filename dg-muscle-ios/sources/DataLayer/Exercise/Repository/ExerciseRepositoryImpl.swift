//
//  ExerciseRepositoryImpl.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

public final class ExerciseRepositoryImpl: Domain.ExerciseRepository {
    public static let shared = ExerciseRepositoryImpl()
    
    public var exercises: AnyPublisher<[Domain.Exercise], Never> { $_exercises.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    @Published var _exercises: [Domain.Exercise] = [] {
        didSet {
            saveMyExercisesToFileManager(exercises: _exercises)
        }
    }
    
    public func get() -> [Domain.Exercise] {
        _exercises
    }
    
    private init() { 
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
            .sink { isLogin in
                if isLogin {
                    Task {
                        self._exercises = await self.geyMyExercisesFromFileManager()
                        self._exercises = try await self.getMyExercisesFromServer()
                    }
                } else {
                    self._exercises = []
                }
            }
            .store(in: &cancellables)
    }
    
    public func post(_ exercise: Domain.Exercise) async throws {
        if let index = _exercises.firstIndex(where: { $0.id == exercise.id }) {
            _exercises[index] = exercise
        } else {
            _exercises.append(exercise)
        }
        
        let url = FunctionsURL.exercise(.postexercise)
        let data: Exercise = .init(domain: exercise)
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: data
        )
    }
    
    public func delete(_ exercise: Domain.Exercise) async throws {
        if let index = _exercises.firstIndex(where: { $0.id == exercise.id }) {
            _exercises.remove(at: index)
        }
        
        struct Body: Codable {
            let id: String
        }
        
        let url = FunctionsURL.exercise(.deleteexercise)
        let body: Body = .init(id: exercise.id)
        let _: DataResponse = try await APIClient.shared.request(
            method: .delete,
            url: url,
            body: body
        )
    }
    
    private func getMyExercisesFromServer() async throws -> [Domain.Exercise] {
        let url = FunctionsURL.exercise(.getexercises)
        let exercises: [Exercise] = try await APIClient.shared.request(url: url)
        return exercises.map({ $0.domain })
    }
    
    private func geyMyExercisesFromFileManager() async -> [Domain.Exercise] {
        return await withCheckedContinuation { continuation in
            let exercises: [Exercise] = (try? FileManagerHelper.shared.load([Exercise].self, fromFile: .exercise)) ?? []
            continuation.resume(returning: exercises.map({ $0.domain }))
        }
    }
    
    private func saveMyExercisesToFileManager(exercises: [Domain.Exercise]) {
        DispatchQueue.global(qos: .background).async {
            let exercises: [Exercise] = exercises.map({ .init(domain: $0) })
            try? FileManagerHelper.shared.save(exercises, toFile: .exercise)
        }
    }
}
