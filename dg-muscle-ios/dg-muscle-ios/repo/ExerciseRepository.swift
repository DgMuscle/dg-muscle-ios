//
//  ExerciseRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

final class ExerciseRepository {
    static let shared = ExerciseRepository()
    private init() { }
    
    func get(uid: String? = nil) async throws -> [Exercise] {
        if let uid {
            try await APIClient.shared.request(url: "https://exercise-getexercises-kpjvgnqz6a-uc.a.run.app", additionalHeaders: ["uid": uid])
        } else {
            try await APIClient.shared.request(url: "https://exercise-getexercises-kpjvgnqz6a-uc.a.run.app")
        }
    }
    
    func delete(id: String) async throws -> DefaultResponse {
        
        struct Parameter: Codable {
            let id: String
        }
        
        let parameter = Parameter(id: id)
        
        return try await APIClient.shared.request(method: .delete, url: "https://exercise-postexercise-kpjvgnqz6a-uc.a.run.app", body: parameter)
    }
    
    func post(data: Exercise) async throws -> DefaultResponse {
        return try await APIClient.shared.request(method: .post, url: "https://exercise-postexercise-kpjvgnqz6a-uc.a.run.app", body: data)
    }
}
