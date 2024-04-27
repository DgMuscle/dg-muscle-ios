//
//  UserData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct UserData: Codable {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    
    init(from: UserDomain) {
        uid = from.uid
        displayName = from.displayName
        photoURL = from.photoURL
    }
    
    var domain: UserDomain {
        .init(uid: uid, displayName: displayName, photoURL: photoURL)
    }
}
