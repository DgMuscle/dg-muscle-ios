//
//  UserDomain.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct UserDomain {
    let uid: String
    var displayName: String?
    var photoURL: URL?
    var heatmapColor: HeatmapColorDomain
}
