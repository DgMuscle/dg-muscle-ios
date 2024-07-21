//
//  RapidRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine
import Domain

public final class RapidRepositoryImpl: RapidRepository {
    public static let shared = RapidRepositoryImpl()
    
    public var exercises: AnyPublisher<[Domain.RapidExerciseDomain], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published private var _exercises: [Domain.RapidExerciseDomain] = []
    
    private var apiKey: String = ""
    
    private init() {
        Task {
            let apiKey = try await fetchApiKey()
            self.apiKey = apiKey
        }
    }
    
    public func get() -> [Domain.RapidExerciseDomain] {
        _exercises
    }
    
    private func fetchApiKey() async throws -> String {
        struct Response: Codable {
            let apiKey: String
        }
        
        let response: Response = try await APIClient.shared.request(url: FunctionsURL.rapid(.getapikey))
        return response.apiKey
    }
    
}
