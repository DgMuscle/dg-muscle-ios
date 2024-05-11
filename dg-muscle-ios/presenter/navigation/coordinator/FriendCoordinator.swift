//
//  FriendCoordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import SwiftUI

final class FriendCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func list() {
        path.append(FriendNavigation(name: .list))
    }
    
    func search() {
        path.append(FriendNavigation(name: .search))
    }
    
    func requestList() {
        path.append(FriendNavigation(name: .requestList))
    }
    
    func historyList(friend: UserV, today: Date) {
        path.append(FriendNavigation(friend: friend, today: today))
    }
}
