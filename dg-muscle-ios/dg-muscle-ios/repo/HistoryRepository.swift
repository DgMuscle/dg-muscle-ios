//
//  HistoryRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

final class HistoryRepository {
    static let shared = HistoryRepository()
    
    private init () { }
    
    func getCache() -> [ExerciseHistory] {
        (try? FileManagerHelper.load([ExerciseHistory].self, fromFile: .history)) ?? []
    }
    
    func saveCache(histories: [ExerciseHistory]) throws {
        try FileManagerHelper.save(histories, toFile: .history)
    }
    
    func get(lastId: String?, limit: Int) async throws -> [ExerciseHistory] {
        var url = "https://exercisehistory-gethistories-kpjvgnqz6a-uc.a.run.app?limit=\(limit)"
        
        if let lastId {
            url = url + "&lastId=\(lastId)"
        }
        
        return try await APIClient.shared.request(url: url)
    }
    
    func post(data: ExerciseHistory) async throws -> DefaultResponse {
        try await APIClient.shared.request(method: .post, url: "https://exercisehistory-posthistory-kpjvgnqz6a-uc.a.run.app", body: data)
    }
    
    func delete(data: ExerciseHistory) async throws -> DefaultResponse {
        struct Parameter: Codable {
            let id: String
        }
        let data = Parameter(id: data.id)
        return try await APIClient.shared.request(method: .delete, url: "https://exercisehistory-deletehistory-kpjvgnqz6a-uc.a.run.app", body: data)
    }
}
