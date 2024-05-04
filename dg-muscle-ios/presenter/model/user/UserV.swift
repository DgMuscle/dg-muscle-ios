//
//  UserV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct UserV {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    var isMyFriend: Bool = false
    
    init(from: UserDomain) {
        uid = from.uid
        displayName = from.displayName
        photoURL = from.photoURL
    }
    
    var domain: UserDomain {
        .init(uid: uid, displayName: displayName, photoURL: photoURL)
    }
}
