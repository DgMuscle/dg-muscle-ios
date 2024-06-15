//
//  AppDelegate.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import UIKit
import Firebase
import FirebaseMessaging
import DataLayer
import Common

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
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
}

// Push Notification Center
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
        FriendRepositoryImpl.shared.fetch()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        if let destination = userInfo["destination"] as? String {
            
            if destination == "friend_request" {
                FriendRepositoryImpl.shared.fetch()
                URLManager.shared.open(url: "dgmuscle://friend?anchor=request")
            } else if destination == "friend_list" {
                FriendRepositoryImpl.shared.fetch()
                URLManager.shared.open(url: "dgmuscle://friend")
            }
            
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken {
            UserRepositoryImpl.shared.post(fcmToken: fcmToken)
        }
    }
}
