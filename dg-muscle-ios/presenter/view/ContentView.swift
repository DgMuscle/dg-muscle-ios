//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.window) var window: UIWindow?
    @StateObject var viewModel: ContentViewModel = .init(subscribeIsLoginUsecase: .init(userRepository: UserRepositoryData.shared),
                                                         getIsLoginUsecase: .init(userRepository: UserRepositoryData.shared))
    
    @State var path: NavigationPath = .init()
    
    
    let today = Date()
    let userRepository: UserRepository = UserRepositoryData.shared
    let appleAuthCoordinatorGenerator: AppleAuthCoordinatorGenerator = AppleAuthCoordinatorGeneratorImpl()
    let historyRepository: HistoryRepository = HistoryRepositoryData.shared
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryData.shared
    let healthRepository: HealthRepositoryDomain = HealthRepositoryData.shared
    let authenticator: AuthenticatorInterface = Authenticator()
    let fileUploader: FileUploaderInterface = FileUploader.shared
    let heatmapRepository: HeatmapRepository = HeatmapRepositoryData.shared
    
    var body: some View {
        ZStack {
            if viewModel.isLogin {
                NavigationView(today: today,
                               historyRepository: historyRepository,
                               exerciseRepository: exerciseRepository,
                               healthRepository: healthRepository,
                               userRepository: userRepository,
                               authenticator: authenticator,
                               fileUploader: fileUploader, 
                               heatmapRepository: heatmapRepository)
            } else {
                AppleSignInView(appleSignInUsecase: .init(appleAuthCoordinator: appleAuthCoordinatorGenerator.generate(window: window)))
            }
        }
        .environmentObject(CoordinatorV2(path: $path))
        .animation(.default, value: viewModel.isLogin)
    }
}
