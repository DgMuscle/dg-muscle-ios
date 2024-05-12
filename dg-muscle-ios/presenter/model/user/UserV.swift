//
//  UserV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct UserV: Hashable {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    var isMyFriend: Bool = false
    var heatmapColor: HeatmapColorV
    
    init(from: UserDomain) {
        uid = from.uid
        displayName = from.displayName
        photoURL = from.photoURL
        heatmapColor = .init(color: from.heatmapColor)
    }
    
    var domain: UserDomain {
        .init(uid: uid, displayName: displayName, photoURL: photoURL, heatmapColor: heatmapColor.domain)
    }
}
