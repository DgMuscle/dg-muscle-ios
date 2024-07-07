//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI
import DataLayer
import Domain
import Auth
import Presentation
import Foundation

struct ContentView: View {
    typealias FoundationData = Data
    @Environment(\.window) var window: UIWindow?
    @StateObject var viewModel: ContentViewModel
    @State var splash: Bool = true
    
    init() {
        self._viewModel = .init(wrappedValue: injector.resolve(ContentViewModel.self))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLogin {
                injector.resolve(Presentation.NavigationView.self, argument: Date())
            } else {
                injector.resolve(AuthenticationView.self, argument: window)
            }
            SplashView().opacity((splash || UserRepositoryImpl.shared.isReady == false) ? 1 : 0)
        }
        .animation(.default, value: splash)
        .animation(.default, value: UserRepositoryImpl.shared.isReady)
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
