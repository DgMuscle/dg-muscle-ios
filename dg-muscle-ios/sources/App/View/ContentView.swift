//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI
import Data
import Domain
import Auth

struct ContentView: View {
    typealias FoundationData = Data
    @Environment(\.window) var window: UIWindow?
    @StateObject var viewModel: ContentViewModel
    @State var splash: Bool = true
    
    init() {
        self._viewModel = .init(wrappedValue: .init(userRepository: UserRepositoryImpl.shared))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLogin {
                Text("Logged In")
            } else {
                AuthenticationView(
                    startAppleLoginUsecase: .init(
                        appleAuthCoordinator: AppleAuthCoordinatorImpl(window: window)
                    )
                )
            }
            SplashView().opacity(splash ? 1 : 0)
        }
        .animation(.default, value: splash)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                splash.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
