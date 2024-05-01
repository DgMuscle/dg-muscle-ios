//
//  DeleteAccountUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class DeleteAccountUsecase {
    let authenticator: AuthenticatorInterface
    
    init(authenticator: AuthenticatorInterface) {
        self.authenticator = authenticator
    }
    
    func implement() async throws {
        let error = await authenticator.withDrawal()
        if let error {
            throw error
        }
    }
}
