//
//  UserData.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Domain

struct UserData: Codable {
    let id: String
    let deleted: Bool?
    var displayName: String?
    var backgroundImageURL: String?
    var photoURL: String?
    var heatmapColor: HeatMapColor?
    var fcmToken: String?
    var link: String?
    var developer: Bool?
    var onlyShowsFavoriteExercises: Bool?
    
    init(domain: Domain.User) {
        self.id = domain.uid
        self.displayName = domain.displayName
        self.backgroundImageURL = domain.backgroundImageURL?.absoluteString
        self.photoURL = domain.photoURL?.absoluteString
        self.heatmapColor = .init(domain: domain.heatMapColor)
        self.fcmToken = domain.fcmToken
        self.link = domain.link?.absoluteString
        self.deleted = false
        self.developer = domain.developer
        self.onlyShowsFavoriteExercises = domain.onlyShowsFavoriteExercises
    }
    
    var domain: Domain.User {
        .init(
            uid: id,
            displayName: displayName, 
            backgroundImageURL: .init(string: backgroundImageURL ?? ""),
            photoURL: .init(string: photoURL ?? ""),
            heatMapColor: heatmapColor?.domain ?? .green,
            fcmToken: fcmToken,
            link: .init(string: link ?? ""),
            developer: developer ?? false,
            onlyShowsFavoriteExercises: onlyShowsFavoriteExercises ?? false
        )
    }
}
