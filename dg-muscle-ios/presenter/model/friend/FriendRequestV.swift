//
//  FriendRequestV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

struct FriendRequestV: Hashable {
    let fromId: String
    let createdAt: Date
    
    init(from: FriendRequestDomain) {
        fromId = from.fromId
        createdAt = from.createdAt
    }
    
    var domain: FriendRequestDomain {
        .init(fromId: fromId, createdAt: createdAt)
    }
}
