//
//  AuthenticationViewModel.swift
//  Auth
//
//  Created by 신동규 on 6/17/24.
//

import Foundation
import Combine
import Domain
import Common

final class AuthenticationViewModel: ObservableObject {
    
    @Published var status: Common.StatusView.Status?
    
    private let startAppleLoginUsecase: StartAppleLoginUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(appleAuthCoordinator: any AppleAuthCoordinator) {
        var appleAuthCoordinator = appleAuthCoordinator
        startAppleLoginUsecase = .init(appleAuthCoordinator: appleAuthCoordinator)
        appleAuthCoordinator.delegate = self
    }
    
    func startAppleLogin() {
        startAppleLoginUsecase.implement()
    }
}

extension AuthenticationViewModel: AppleAuthCoordinatorDelegate {
    func error(message: String) {
        status = .error(message)
    }
}
