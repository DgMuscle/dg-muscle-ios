//
//  FriendRequestData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct FriendRequestData: Codable {
    let fromId: String
    let createdAt: CreatedAt
    
    init(from: FriendRequestDomain) {
        fromId = from.fromId
        createdAt = .init(_seconds: from.createdAt.timeIntervalSince1970, _nanoseconds: 0)
    }
    
    var domain: FriendRequestDomain {
        .init(fromId: fromId, createdAt: Date(timeIntervalSince1970: createdAt._seconds))
    }
}
