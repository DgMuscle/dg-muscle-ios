//
//  AuthenticatorInterface.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

protocol AuthenticatorInterface {
    func signOut() throws
    func updateUser(displayName: String?, photoURL: URL?) async throws
    func withDrawal() async -> Error?
}
