//
//  MyCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import SwiftUI

public final class MyCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    public func deleteAccountConfirm() {
        path.append(MyNavigation(name: .deleteAccountConfirm))
    }
    
    public func logs() {
        path.append(MyNavigation(name: .logs))
    }
}
