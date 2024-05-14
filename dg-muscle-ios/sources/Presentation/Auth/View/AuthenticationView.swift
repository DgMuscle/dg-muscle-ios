//
//  AuthenticationView.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    var body: some View {
        Button {
            AppleAuthCoordinator(window: window).startAppleLogin()
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
    AuthenticationView(window: nil).preferredColorScheme(.dark)
}
