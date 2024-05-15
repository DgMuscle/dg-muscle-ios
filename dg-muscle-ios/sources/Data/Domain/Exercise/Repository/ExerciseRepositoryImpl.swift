//
//  ExerciseRepositoryImpl.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

final class ExerciseRepositoryImpl: Domain.ExerciseRepository {
    public static let shared = ExerciseRepositoryImpl()
    
    var exercises: AnyPublisher<[Domain.Exercise], Never> { $_exercises.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    @Published var _exercises: [Domain.Exercise] = [] {
        didSet {
            saveMyExercisesToFileManager(exercises: _exercises)
        }
    }
    
    private init() { 
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.global(qos: .background))
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
