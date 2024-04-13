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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentViewV2(historyViewModel: .init(historyRepository: HistoryRepositoryV2Impl.shared,
                                               healthRepository: HealthRepositoryLive.shared,
                                               userRepository: UserRepositoryV2Live.shared),
                              exerciseRepository: ExerciseRepositoryV2Live.shared,
                              healthRepository: HealthRepositoryLive.shared,
                              userRepository: UserRepositoryV2Live.shared)
                
                SplashView()
                    .opacity(splash ? 1 : 0)
                    .animation(.easeIn, value: splash)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            splash = false
                        }
                    }
            }
        }
    }
}
