//
//  AppleSignInUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class AppleSignInUsecase {
    private let appleAuthCoordinator: AppleAuthCoordinatorInterface
    
    init(appleAuthCoordinator: AppleAuthCoordinatorInterface) {
        self.appleAuthCoordinator = appleAuthCoordinator
    }
    
    func implement() {
        appleAuthCoordinator.startAppleLogin()
    }
}
