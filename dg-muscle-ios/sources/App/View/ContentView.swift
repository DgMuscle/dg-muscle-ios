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
    @Environment(\.window) var window: UIWindow?
    @StateObject var viewModel: ContentViewModel
    
    init() {
        self._viewModel = .init(wrappedValue: .init(userRepository: UserRepositoryImpl.shared))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLogin {
                Text("Logged In")
            } else {
                AuthenticationView(window: window)
            }
        }
    }
}

#Preview {
    ContentView()
}
