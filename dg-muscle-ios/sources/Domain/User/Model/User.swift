//
//  User.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation

public struct User {
    public let uid: String
    public var displayName: String?
    public var photoURL: URL?
    public var backgroundImageURL: URL?
    public var heatMapColor: HeatMapColor
    public var fcmToken: String?
    public var link: URL?
    public var developer: Bool
    
    public init(
        uid: String, 
        displayName: String? = nil,
        backgroundImageURL: URL?,
        photoURL: URL? = nil,
        heatMapColor: HeatMapColor,
        fcmToken: String?,
        link: URL?,
        developer: Bool
    ) {
        self.uid = uid
        self.displayName = displayName
        self.backgroundImageURL = backgroundImageURL
        self.photoURL = photoURL
        self.heatMapColor = heatMapColor
        self.fcmToken = fcmToken
        self.link = link
        self.developer = developer
    }
}
