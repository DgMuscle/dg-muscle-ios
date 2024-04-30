//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @Environment(\.window) var window: UIWindow?
    
    let appleAuthCoordinatorGenerator: AppleAuthCoordinatorGenerator
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseRepository: ExerciseRepository
    let healthRepository: HealthRepositoryDomain
    let userRepository: UserRepository
    let authenticator: AuthenticatorInterface
    let fileUploader: FileUploaderInterface
    
    var body: some View {
        ZStack {
            if viewModel.isLogin {
                NavigationView(today: today,
                               historyRepository: historyRepository,
                               exerciseRepository: exerciseRepository,
                               healthRepository: healthRepository,
                               userRepository: userRepository,
                               authenticator: authenticator,
                               fileUploader: fileUploader)
            } else {
                AppleSignInView(appleSignInUsecase: .init(appleAuthCoordinator: appleAuthCoordinatorGenerator.generate(window: window)))
            }
        }
        .animation(.default, value: viewModel.isLogin)
    }
}
