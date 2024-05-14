//
//  AuthenticationView.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import SwiftUI
import Domain

public struct AuthenticationView: View {
    
    private let startAppleLoginUsecase: StartAppleLoginUsecase
    
    public init(startAppleLoginUsecase: StartAppleLoginUsecase) {
        self.startAppleLoginUsecase = startAppleLoginUsecase
    }
    
    public var body: some View {
        Button {
            startAppleLoginUsecase.implement()
        } label: {
            HStack {
                Image(systemName: "apple.logo")
                Text("Sign In with Apple")
            }
        }
        .foregroundStyle(Color(uiColor: .label))
    }
}

#Preview {
    
    class AppleAuthCoordinatorTest: AppleAuthCoordinator {
        func startAppleLogin() {
            print("startAppleLogin")
        }
    }
    
    return AuthenticationView(startAppleLoginUsecase: .init(appleAuthCoordinator: AppleAuthCoordinatorTest())).preferredColorScheme(.dark)
}
