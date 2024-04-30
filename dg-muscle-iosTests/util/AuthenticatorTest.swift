//
//  AuthenticatorTest.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class AuthenticatorTest: AuthenticatorInterface {
    
    struct AnyError: Error {
        let message: String?
    }
    
    func signOut() throws {
        throw AnyError(message: "test")
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        throw AnyError(message: "test")
    }
    
    func withDrawal() async -> (any Error)? {
        return AnyError(message: "test")
    }
}
