//
//  dg_muscle_iosApp.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI
import Swinject

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
    
    let injector: Injector
    
    init() {
        injector = DependencyInjector(container: Container())
        injector.assemble([
            DataAssembly(),
            CoordinatorAssembly(),
            ExerciseAssembly(),
            ExerciseTimerAssembly(),
            FriendAssembly(),
            HistoryAssembly(),
            HomeAssembly(),
            MyAssembly(),
            RapidAssembly(),
            WeightAssembly(),
            MainAssembly()
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(injector: injector)
        }
    }
}
