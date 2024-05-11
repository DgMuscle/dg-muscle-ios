//
//  FriendNavigation.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct FriendNavigation: Identifiable, Hashable {
    static func == (lhs: FriendNavigation, rhs: FriendNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    enum Name: String {
        case list
        case search
        case requestList
        case historyList
    }
    
    var id: Int { name.hashValue }
    let name: Name
    var historyList: (UserV, Date)? = nil
    
    init(name: Name) {
        self.name = name
    }
    
    init(friend: UserV, today: Date) {
        self.name = .historyList
        self.historyList = (friend, today)
    }
}
