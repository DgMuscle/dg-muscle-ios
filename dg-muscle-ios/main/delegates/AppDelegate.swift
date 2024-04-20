//
//  AppDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        setShortCutItems()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: connectingSceneSession.configuration.name, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
    
    private func setShortCutItems() {
        UIApplication.shared.shortcutItems = [
            generateShortCutItem(action: .init(type: .record), icon: .init(type: .compose))
        ]
    }
    
    private func generateShortCutItem(action: QuickAction, icon: UIApplicationShortcutIcon?) -> UIApplicationShortcutItem {
        return .init(type: action.type.rawValue, localizedTitle: action.title, localizedSubtitle: action.subTitle, icon: icon)
    }
}
