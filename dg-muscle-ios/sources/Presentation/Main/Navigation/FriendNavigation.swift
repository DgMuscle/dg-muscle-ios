//
//  FriendNavigation.swift
//  Presentation
//
//  Created by 신동규 on 6/9/24.
//

import Foundation
import Friend

public struct FriendNavigation: Hashable {
    public static func == (lhs: FriendNavigation, rhs: FriendNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID().uuidString
    let name: Name
}

extension FriendNavigation {
    public enum Name {
        case main(PageAnchorView.Page)
        case history(String)
    }
}
