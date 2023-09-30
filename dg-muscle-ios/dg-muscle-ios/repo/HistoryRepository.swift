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
    
    func get(lastId: Int?) async throws -> [ExerciseHistory] {
        var url = "https://exercisehistory-gethistories-kpjvgnqz6a-uc.a.run.app"
        
        if let lastId {
            url = url + "?lastId=\(lastId)"
        }
        
        return try await APIClient.shared.request(url: url) as [ExerciseHistory]
    }
    
    func post(data: ExerciseHistory) async throws -> DefaultResponse {
        try await APIClient.shared.request(method: .post, url: "https://exercisehistory-posthistory-kpjvgnqz6a-uc.a.run.app", body: data)
    }
}
