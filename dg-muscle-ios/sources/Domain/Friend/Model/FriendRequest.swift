//
//  FriendRequest.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation

public struct FriendRequest {
    public let fromId: String
    public let createdAt: Date
    
    public init(
        fromId: String,
        createdAt: Date
    ) {
        self.fromId = fromId
        self.createdAt = createdAt
    }
}
