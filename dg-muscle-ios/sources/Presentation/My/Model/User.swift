//
//  User.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct User {
    let uid: String
    let displayName: String?
    let photoURL: URL?
    let heatMapColor: HeatMapColor
    
    init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.photoURL = domain.photoURL
        self.heatMapColor = .init(domain: domain.heatMapColor)
    }
    
    var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            photoURL: photoURL,
            heatMapColor: heatMapColor.domain
        )
    }
}
