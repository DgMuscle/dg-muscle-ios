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
}
