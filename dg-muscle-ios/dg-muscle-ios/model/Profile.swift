//
//  Profile.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/8/23.
//

import Foundation

struct Profile: Codable {
    let id: String
    let photoURL: String?
    let displayName: String?
    let updatedAt: CreatedAt?
}
