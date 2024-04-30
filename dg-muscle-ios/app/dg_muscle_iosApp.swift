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
                ContentView()
                
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
    }
}
