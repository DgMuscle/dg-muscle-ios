//
//  Friend.swift
//  App
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Common

struct Friend: Hashable {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    var backgroundImageURL: URL?
    var heatMapColor: Common.HeatMapColor
    
    init(domain: Domain.User) {
        uid = domain.uid
        displayName = domain.displayName
        photoURL = domain.photoURL
        backgroundImageURL = domain.backgroundImageURL
        heatMapColor = .init(domain: domain.heatMapColor)
    }
    
    var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            backgroundImageURL: backgroundImageURL,
            photoURL: photoURL,
            heatMapColor: heatMapColor.domain,
            fcmToken: nil
        )
    }
}
