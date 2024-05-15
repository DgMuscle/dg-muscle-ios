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
    
    init(uid: String, displayName: String? = nil, photoURL: String? = nil) {
        self.uid = uid
        self.displayName = displayName
        self.photoURL = photoURL
    }
    
    init(domain: Domain.User) {
        self.uid = domain.uid
        self.displayName = domain.displayName
        self.photoURL = domain.photoURL?.absoluteString
    }
    
    var domain: Domain.User {
        .init(
            uid: uid,
            displayName: displayName,
            photoURL: .init(string: photoURL ?? "")
        )
    }
}
