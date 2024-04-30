//
//  SignOutUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class SignOutUsecase {
    let authenticator: AuthenticatorInterface
    
    init(authenticator: AuthenticatorInterface) {
        self.authenticator = authenticator
    }
    
    func implement() throws {
        try authenticator.signOut()
    }
}
