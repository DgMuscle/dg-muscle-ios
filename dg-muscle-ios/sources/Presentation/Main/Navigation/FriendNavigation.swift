//
//  FriendNavigation.swift
//  Presentation
//
//  Created by 신동규 on 6/9/24.
//

import Foundation

public struct FriendNavigation: Hashable {
    let name: Name
}

extension FriendNavigation {
    public enum Name {
        case main
    }
}
