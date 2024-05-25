//
//  FriendRequest.swift
//  DataLayer
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Domain

struct FriendRequest: Codable {
    let fromId: String
    let createdAt: CreatedAt
    
    init(domain: Domain.FriendRequest) {
        fromId = domain.fromId
        createdAt = .init(_seconds: domain.createdAt.timeIntervalSince1970, _nanoseconds: 0)
    }
    
    var domain: Domain.FriendRequest {
        .init(
            fromId: fromId,
            createdAt: Date(timeIntervalSince1970: createdAt._seconds)
        )
    }
}
