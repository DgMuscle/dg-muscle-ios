//
//  UserRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/8/23.
//

import Foundation

final class UserRepository {
    static let shared = UserRepository()
    private init() { }
    
    func postProfile(profile: Profile) async throws -> DefaultResponse {
        return try await APIClient.shared.request(method: .post, url: "https://user-postprofile-kpjvgnqz6a-uc.a.run.app", body: profile)
    }
    
    func getProfile() async throws -> Profile {
        return try await APIClient.shared.request(url: "https://user-getprofile-kpjvgnqz6a-uc.a.run.app")
    }
}
