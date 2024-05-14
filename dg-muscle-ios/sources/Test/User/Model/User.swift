//
//  User.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Domain

struct User {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    
    init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.photoURL = domain.photoURL
    }
    
    var domain: Domain.User {
        .init(uid: uid, displayName: displayName, photoURL: photoURL)
    }
}
