//
//  Authenticator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import FirebaseAuth

final class Authenticator {
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
