//
//  MainCoordinatorV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

final class MainCoordinatorV2 {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func setting() {
        path.append(MainNavigationV2(name: .setting))
    }
    
    func heatmapColor() {
        path.append(MainNavigationV2(name: .heatmapColor))
    }
}
