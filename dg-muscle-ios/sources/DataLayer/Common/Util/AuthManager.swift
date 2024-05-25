//
//  AuthManager.swift
//  Data
//
//  Created by Donggyu Shin on 5/16/24.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.photoURL = photoURL
        try await changeRequest?.commitChanges()
    }
    
    func updateUser(displayName: String?) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        try await changeRequest?.commitChanges()
    }
    
    func updateUser(photoURL: URL?) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        try await changeRequest?.commitChanges()
    }
    
    func withDrawal() async -> Error? {
        return await withCheckedContinuation { continuation in
            Auth.auth().currentUser?.delete(completion: { error in
                continuation.resume(returning: error)
            })
        }
    }
}
