//
//  User.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public struct User: Hashable, Identifiable {
    public var id: String { uid }
    
    public let uid: String
    public let displayName: String?
    public let backgroundImageURL: URL?
    public let photoURL: URL?
    public let heatMapColor: HeatMapColor
    public let fcmToken: String?
    public let link: URL?
    public let developer: Bool
    
    public init() {
        uid = UUID().uuidString
        displayName = nil
        backgroundImageURL = nil
        photoURL = nil
        heatMapColor = .green
        fcmToken = nil 
        link = nil
        developer = false
    }
    
    public init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.backgroundImageURL = domain.backgroundImageURL
        self.photoURL = domain.photoURL
        self.heatMapColor = .init(domain: domain.heatMapColor)
        self.fcmToken = domain.fcmToken
        self.link = domain.link
        self.developer = domain.developer
    }
    
    public var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName, 
            backgroundImageURL: backgroundImageURL,
            photoURL: photoURL,
            heatMapColor: heatMapColor.domain,
            fcmToken: fcmToken,
            link: link,
            developer: developer
        )
    }
}
