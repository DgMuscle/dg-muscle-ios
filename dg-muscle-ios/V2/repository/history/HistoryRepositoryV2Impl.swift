//
//  HistoryRepositoryV2Impl.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import WidgetKit

final class HistoryRepositoryV2Impl: HistoryRepositoryV2 {
    static let shared = HistoryRepositoryV2Impl()
    
    var histories: [ExerciseHistory] {
        _histories
    }
    
    var historiesPublisher: AnyPublisher<[ExerciseHistory], Never> {
        $_histories.eraseToAnyPublisher()
    }
    
    @Published private var _histories: [ExerciseHistory] = []
    
    private init() {
        _histories = getExerciseHistoryFromFile()
        
        Task {
            _histories = try await get(lastId: nil, limit: 365)
        }
    }
    
    func get() throws -> [WorkoutHeatMapViewModel.Data] {
        try FileManagerHelper.load([WorkoutHeatMapViewModel.Data].self, fromFile: .workoutHeatMapData)
    }
    
    func post(data: ExerciseHistory) async throws -> DefaultResponse {
        
        if let index = histories.firstIndex(where: { $0.id == data.id }) {
            _histories[index] = data
        } else {
            _histories.insert(data, at: 0)
        }
        
        try? FileManagerHelper.save(histories, toFile: .history)
        
        return try await APIClient.shared.request(method: .post, url: "https://exercisehistory-posthistory-kpjvgnqz6a-uc.a.run.app", body: data)
    }
    
    func post(data: [WorkoutHeatMapViewModel.Data]) throws {
        try FileManagerHelper.save(data, toFile: .workoutHeatMapData)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func delete(data: ExerciseHistory) async throws -> DefaultResponse {
        struct Parameter: Codable {
            let id: String
        }
        let data = Parameter(id: data.id)
        
        if let index = _histories.firstIndex(where: { $0.id == data.id }) {
            _histories.remove(at: index)
        }
        
        try? FileManagerHelper.save(histories, toFile: .history)
        
        return try await APIClient.shared.request(method: .delete, url: "https://exercisehistory-deletehistory-kpjvgnqz6a-uc.a.run.app", body: data)
    }
    
    private func getExerciseHistoryFromFile() -> [ExerciseHistory] {
        (try? FileManagerHelper.load([ExerciseHistory].self, fromFile: .history)) ?? []
    }
    
    private func get(lastId: String?, limit: Int) async throws -> [ExerciseHistory] {
        var url = "https://exercisehistory-gethistories-kpjvgnqz6a-uc.a.run.app?limit=\(limit)"
        
        if let lastId {
            url = url + "&lastId=\(lastId)"
        }
        
        let histories: [ExerciseHistory] = try await APIClient.shared.request(url: url)
        
        try? FileManagerHelper.save(histories, toFile: .history)
        
        return histories
    }
}
