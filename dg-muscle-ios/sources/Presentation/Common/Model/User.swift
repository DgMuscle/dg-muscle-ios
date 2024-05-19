//
//  User.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public struct User {
    public let uid: String
    public let displayName: String?
    public let photoURL: URL?
    public let heatMapColor: HeatMapColor
    public let fcmToken: String?
    
    public init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.photoURL = domain.photoURL
        self.heatMapColor = .init(domain: domain.heatMapColor)
        self.fcmToken = domain.fcmToken
    }
    
    public var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            photoURL: photoURL,
            heatMapColor: heatMapColor.domain,
            fcmToken: fcmToken
        )
    }
}
