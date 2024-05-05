//
//  FriendNavigation.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct FriendNavigation: Identifiable, Hashable {
    enum Name: String {
        case list
        case search
        case requestList
    }
    
    var id: Int { name.hashValue }
    let name: Name
}
