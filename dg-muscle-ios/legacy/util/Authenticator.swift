//
//  Authenticator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import Foundation
import FirebaseAuth

final class Authenticator {
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
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
