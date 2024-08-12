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
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var cancellables = Set<AnyCancellable>()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound, .provisional]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        application.shortcutItems = [
            UIApplicationShortcutItem(
                type: "dgmuscle://history",
                localizedTitle: "Quick Record",
                localizedSubtitle: "move to today record page directly",
                icon: .init(systemImageName: "figure.snowboarding")
            )
        ]
        
        applicationDataBinding()
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: connectingSceneSession.configuration.name, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
    
    private func applicationDataBinding() {
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
            .filter({ $0 })
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { isLogin in
                Task {
                    try await HistoryRepositoryImpl.shared.getMyHistoriesFromServer(lastId: nil, limit: 365)
                }
                
                Task {
                    try await ExerciseRepositoryImpl.shared.getMyExercisesFromServer()
                }
                
                FriendRepositoryImpl.shared.fetch()
                RapidRepositoryImpl.shared.fetch()
                LogRepositoryImpl.shared.fetchLogs()
            }
            .store(in: &cancellables)
    }
}

// Push Notification Center
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
        
        let userInfo = notification.request.content.userInfo
        
        guard let type = userInfo["type"] as? String else { return }
        
        if type == "timer" {
            guard let targetDate = userInfo["targetDate"] as? Date else { return }
            let nowTimeInterval = Date().timeIntervalSince1970
            let targetDateTimeInterval = targetDate.timeIntervalSince1970
            let diff = nowTimeInterval - targetDateTimeInterval
            
            if diff < 180 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    print("dg: keep sending timer push")
                }
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        if let destination = userInfo["destination"] as? String {
            
            switch destination {
            case "friend_request":
                FriendRepositoryImpl.shared.fetch()
                URLManager.shared.open(url: "dgmuscle://friend?anchor=request")
            case "friend_list":
                FriendRepositoryImpl.shared.fetch()
                URLManager.shared.open(url: "dgmuscle://friend")
            case "logs":
                URLManager.shared.open(url: "dgmuscle://logs")
            default: break
            }
        }
        
        if let type = userInfo["type"] as? String {
            if type == "timer" {
                print("dg: cancel all timer pushs")
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
