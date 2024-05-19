//
//  UserData.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Domain

struct UserData: Codable {
    let uid: String
    var displayName: String?
    var photoURL: String?
    var heatMapColor: HeatMapColor?
    var fcmToken: String?
    
    init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.photoURL = domain.photoURL?.absoluteString
        self.heatMapColor = .init(domain: domain.heatMapColor)
        self.fcmToken = domain.fcmToken
    }
    
    var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            photoURL: .init(string: photoURL ?? ""),
            heatMapColor: heatMapColor?.domain ?? .green,
            fcmToken: fcmToken
        )
    }
}
