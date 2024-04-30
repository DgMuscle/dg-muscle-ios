//
//  dg_muscle_iosApp.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI
import FirebaseCore

struct WindowKey: EnvironmentKey {
    struct Value {
        weak var value: UIWindow?
    }
    
    static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
    var window: UIWindow? {
        get {
            return self[WindowKey.self].value
        }
        set {
            self[WindowKey.self] = .init(value: newValue)
        }
    }
}

@main
struct dg_muscle_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var splash = true
    @State var path = NavigationPath()
    
    let today = Date()
    let userRepository: UserRepository = UserRepositoryData.shared
    let appleAuthCoordinatorGenerator: AppleAuthCoordinatorGenerator = AppleAuthCoordinatorGeneratorImpl()
    let historyRepository: HistoryRepository = HistoryRepositoryData.shared
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryData.shared
    let healthRepository: HealthRepositoryDomain = HealthRepositoryData.shared
    let authenticator: AuthenticatorInterface = Authenticator()
    let fileUploader: FileUploaderInterface = FileUploader.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(viewModel: .init(subscribeIsLoginUsecase: .init(userRepository: userRepository),
                                             getIsLoginUsecase: .init(userRepository: userRepository)),
                            appleAuthCoordinatorGenerator: appleAuthCoordinatorGenerator,
                            today: today,
                            historyRepository: historyRepository,
                            exerciseRepository: exerciseRepository,
                            healthRepository: healthRepository,
                            userRepository: userRepository,
                            authenticator: authenticator,
                            fileUploader: fileUploader)
                
                if splash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                splash.toggle()
                            }
                        }
                }
            }
            .animation(.easeIn, value: splash)
        }
        .environmentObject(CoordinatorV2(path: $path))
        
    }
}
