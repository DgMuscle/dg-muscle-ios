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
    @Environment(\.window) var window: UIWindow?
    @State var splash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentViewV2(viewModel: .init(userRepository: UserRepositoryV2Live.shared),
                              historyViewModel: .init(historyRepository: HistoryRepositoryV2Impl.shared,
                                                      healthRepository: HealthRepositoryLive.shared,
                                                      userRepository: UserRepositoryV2Live.shared),
                              exerciseRepository: ExerciseRepositoryV2Live.shared,
                              healthRepository: HealthRepositoryLive.shared,
                              userRepository: UserRepositoryV2Live.shared,
                              historyRepository: HistoryRepositoryV2Impl.shared,
                              today: Date(),
                              appleAuth: AppleAuthCoordinator(window: window), 
                              fileUploader: FileUploader.shared, 
                              heatmapRepository: HeatmapRepositoryImpl.shared)
                
                SplashView()
                    .opacity(splash ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            splash = false
                        }
                    }
            }
            .animation(.default, value: splash)
        }
    }
}
