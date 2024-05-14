//
//  StartAppleLoginUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public final class StartAppleLoginUsecase {
    private let appleAuthCoordinator: AppleAuthCoordinator
    
    public init(appleAuthCoordinator: AppleAuthCoordinator) {
        self.appleAuthCoordinator = appleAuthCoordinator
    }
    
    public func implement() {
        appleAuthCoordinator.startAppleLogin()
    }
}
