//
//  AuthenticationView.swift
//  App
//
//  Created by 신동규 on 5/14/24.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        Button {
            
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
    AuthenticationView().preferredColorScheme(.dark)
}
