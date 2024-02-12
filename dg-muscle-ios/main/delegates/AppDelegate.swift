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
        let recordAction = QuickAction(type: .record)
        let composeItem = UIApplicationShortcutItem(type: recordAction.type.rawValue, localizedTitle: recordAction.title, localizedSubtitle: recordAction.subTitle, icon: .init(type: .compose))
        
        UIApplication.shared.shortcutItems = [composeItem]
    }
}
