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
                Presentation.NavigationView(
                    today: Date(),
                    historyRepository: HistoryRepositoryImpl.shared,
                    exerciseRepository: ExerciseRepositoryImpl.shared,
                    heatMapRepository: HeatMapRepositoryImpl.shared,
                    userRepository: UserRepositoryImpl.shared, 
                    friendRepository: FriendRepositoryImpl.shared, 
                    runRepository: RunRepositoryImpl.shared, 
                    logRepository: LogRepositoryImpl.shared
                )
            } else {
                AuthenticationView(appleAuthCoordinator: AppleAuthCoordinatorImpl(window: window))
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
