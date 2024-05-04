//
//  AppDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        setShortCutItems()
        
        // 원격알림 등록: 알람 허용
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
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

extension AppDelegate: UNUserNotificationCenterDelegate { }

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken {
            print("dg: fcmToken is \(fcmToken)")
        }
    }
}
