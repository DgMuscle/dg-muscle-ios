//
//  AppleAuthViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/17/24.
//

import Foundation
import Combine

final class AppleAuthViewModel: ObservableObject {
    let appleAuth: AppleAuth
    
    init(appleAuth: AppleAuth) {
        self.appleAuth = appleAuth
    }
    
    func tapAppleLoginButton() {
        appleAuth.startAppleLogin()
    }
}
