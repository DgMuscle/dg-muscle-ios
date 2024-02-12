//
//  Subscriber.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import Foundation

let subscriber = Subscriber.shared

final class Subscriber {
    static let shared = Subscriber()
    
    let quickAction = QuickActionSubscriber.shared
    
    private init() { }
}
