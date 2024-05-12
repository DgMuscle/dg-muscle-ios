//
//  UserData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct UserData: Codable {
    let id: String
    var displayName: String?
    var photoURL: URL?
    var heatmapColor: HeatmapColorData?
    
    init(from: UserDomain) {
        id = from.uid
        displayName = from.displayName
        photoURL = from.photoURL
        heatmapColor = .init(color: from.heatmapColor)
    }
    
    var domain: UserDomain {
        .init(uid: id, displayName: displayName, photoURL: photoURL, heatmapColor: heatmapColor?.domain ?? .green)
    }
}
