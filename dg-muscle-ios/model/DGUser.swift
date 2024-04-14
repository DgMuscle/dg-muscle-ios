//
//  DGUser.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Foundation

struct DGUser: Codable {
    let uid: String
    var displayName: String?
    var photoURL: URL?
}
