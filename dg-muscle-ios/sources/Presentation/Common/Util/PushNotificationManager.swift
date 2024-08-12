//
//  PushNotificationManager.swift
//  Common
//
//  Created by Happymoonday on 8/12/24.
//

import Foundation
import UserNotifications

final class PushNotificationManager {
    static let shared = PushNotificationManager()
    
    private init() { }
    
    func register(title: String, body: String, date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    func delete(ids: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
