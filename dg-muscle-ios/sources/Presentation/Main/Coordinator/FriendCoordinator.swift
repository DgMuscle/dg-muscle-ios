//
//  FriendCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/13/24.
//

import SwiftUI
import Friend

public final class FriendCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    public func friendMainView(anchor: PageAnchorView.Page) {
        path.append(FriendNavigation(name: .main(anchor) ))
    }
    
    public func friendHistory(friendId: String) {
        path.append(FriendNavigation(name: .history(friendId)))
    }
    
    public func friendHistoryDetail(friendId: String, historyId: String) {
        path.append(FriendNavigation(name: .historyDetail(friendId, historyId)))
    }
}
