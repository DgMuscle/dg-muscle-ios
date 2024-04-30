//
//  AppleSignInView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct AppleSignInView: View {
    let appleSignInUsecase: AppleSignInUsecase
    var body: some View {
        Button {
            appleSignInUsecase.implement()
        } label: {
            Label("Sign in with apple ID", systemImage: "applelogo")
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}

#Preview {
    AppleSignInView(appleSignInUsecase: .init(appleAuthCoordinator: AppleAuthTest()))
        .preferredColorScheme(.dark)
}
