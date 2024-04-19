//
//  AppleAuthView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/17/24.
//

import SwiftUI

struct AppleAuthView: View {
    
    @StateObject var viewModel: AppleAuthViewModel
    
    var body: some View {
        Button {
            viewModel.tapAppleLoginButton()
        } label: {
            Label("Sign in with apple ID", systemImage: "applelogo")
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}

#Preview {
    
    let viewModel: AppleAuthViewModel = .init(appleAuth: AppleAuthCoordinator(window: nil))
    
    return AppleAuthView(viewModel: viewModel).preferredColorScheme(.dark)
}
