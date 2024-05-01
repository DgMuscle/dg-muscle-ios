//
//  ExerciseRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

final class ExerciseRepositoryData: ExerciseRepository {
    static let shared = ExerciseRepositoryData()
    
    var exercises: [ExerciseDomain] { _exercises }
    var exercisesPublisher: AnyPublisher<[ExerciseDomain], Never> { $_exercises.eraseToAnyPublisher() }
    @Published private var _exercises: [ExerciseDomain] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        _exercises = fetchExerciseDataFromFile()
        bind()
    }
    
    func post(data: ExerciseDomain) async throws {
        _exercises.append(data)
        let datas: [ExerciseData] = exercises.map({ .init(from: $0) })
        try FileManagerHelperV2.shared.save(datas, toFile: .exercise)
        let _: ResponseData = try await APIClient.shared.request(method: .post, url: FunctionsURL.exercise(.postexercise),
                                                                 body: ExerciseData(from: data))
    }
    
    func edit(data: ExerciseDomain) async throws {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises[index] = data
        }
        
        let datas: [ExerciseData] = exercises.map({ .init(from: $0) })
        
        try FileManagerHelperV2.shared.save(datas, toFile: .exercise)
        let _: ResponseData = try await APIClient.shared.request(method: .edit, url: FunctionsURL.exercise(.postexercise),
                                                                 body: ExerciseData(from: data))
    }
    
    func delete(data: ExerciseDomain) async throws {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises.remove(at: index)
        }
        let datas: [ExerciseData] = exercises.map({ .init(from: $0) })
        try FileManagerHelperV2.shared.save(datas, toFile: .exercise)
        
        struct Body: Codable {
            let id: String
        }
        
        let body = Body(id: data.id)
        let _: ResponseData = try await APIClient.shared.request(method: .delete, 
                                                                 url: FunctionsURL.exercise(.deleteexercise),
                                                                 body: body)
    }
    
    func get(exerciseId: String) -> ExerciseDomain? {
        exercises.first(where: { $0.id == exerciseId })
    }
    
    private func fetchExerciseDataFromFile() -> [ExerciseDomain] {
        let datas = (try? FileManagerHelperV2.shared.load([ExerciseData].self, fromFile: .exercise)) ?? []
        return datas.map({ $0.domain })
    }
    
    private func fetchExerciseDataFromServer() async throws -> [ExerciseDomain] {
        let exerciseDatas: [ExerciseData] = try await APIClient.shared.request(url: FunctionsURL.exercise(.getexercises))
        try FileManagerHelperV2.shared.save(exerciseDatas, toFile: .exercise)
        return exerciseDatas.map { $0.domain }
    }
    
    private func bind() {
        UserRepositoryData.shared
            .isLoginPublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { login in
                if login {
                    Task {
                        self._exercises = try await self.fetchExerciseDataFromServer()
                    }
                } else {
                    self._exercises = []
                }
            }
            .store(in: &cancellables)
    }
}
