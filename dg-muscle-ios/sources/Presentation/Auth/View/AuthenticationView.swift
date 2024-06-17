//
//  AuthenticationView.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import SwiftUI
import Domain
import Common

public struct AuthenticationView: View {
    
    @StateObject var viewModel: AuthenticationViewModel
    
    public init(appleAuthCoordinator: any AppleAuthCoordinator) {
        _viewModel = .init(wrappedValue: .init(appleAuthCoordinator: appleAuthCoordinator))
    }
    
    public var body: some View {
        VStack {
            
            if let status = viewModel.status {
                Common.StatusView(status: status)
            }
            
            Button {
                viewModel.startAppleLogin()
            } label: {
                HStack {
                    Image(systemName: "apple.logo")
                    Text("Sign In with Apple")
                }
            }
            .foregroundStyle(Color(uiColor: .label))
        }
        .animation(.default, value: viewModel.status)
    }
}

#Preview {
    
    class AppleAuthCoordinatorTest: AppleAuthCoordinator {
        var delegate: (any Domain.AppleAuthCoordinatorDelegate)? = nil
        
        func startAppleLogin() {
            print("startAppleLogin")
        }
    }
    
    return AuthenticationView(appleAuthCoordinator: AppleAuthCoordinatorTest())
        .preferredColorScheme(.dark)
}
