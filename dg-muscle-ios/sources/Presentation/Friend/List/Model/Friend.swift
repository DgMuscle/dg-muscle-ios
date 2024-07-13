//
//  Friend.swift
//  App
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Common

struct Friend: Hashable, Identifiable {
    var id: String { uid }
    let uid: String
    var displayName: String?
    var photoURL: URL?
    var backgroundImageURL: URL?
    var heatMapColor: Common.HeatMapColor
    var link: URL?
    var developer: Bool
    var onlyShowsFavoriteExercises: Bool
    
    init(domain: Domain.User) {
        uid = domain.uid
        displayName = domain.displayName
        photoURL = domain.photoURL
        backgroundImageURL = domain.backgroundImageURL
        heatMapColor = .init(domain: domain.heatMapColor)
        link = domain.link
        developer = domain.developer
        onlyShowsFavoriteExercises = domain.onlyShowsFavoriteExercises
    }
    
    var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            backgroundImageURL: backgroundImageURL,
            photoURL: photoURL,
            heatMapColor: heatMapColor.domain,
            fcmToken: nil, 
            link: link,
            developer: developer,
            onlyShowsFavoriteExercises: onlyShowsFavoriteExercises
        )
    }
}
