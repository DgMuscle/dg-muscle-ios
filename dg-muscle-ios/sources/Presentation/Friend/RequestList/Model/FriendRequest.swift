//
//  FriendRequest.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Common

struct FriendRequest: Hashable, Identifiable {
    var id: String {
        user.uid
    }
    let user: Common.User
    let createdAt: Date
    
    var domain: Domain.FriendRequest {
        .init(fromId: user.uid, createdAt: createdAt)
    }
}
