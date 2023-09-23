//
//  SignInView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @Environment(\.window) var window: UIWindow?
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    
    var body: some View {
        VStack {
            Button("apple sign in ") {
                appleLoginCoordinator = AppleAuthCoordinator(window: window)
                appleLoginCoordinator?.startAppleLogin()
            }
        }
    }
}
