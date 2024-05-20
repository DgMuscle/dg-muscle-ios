//
//  Coordinator.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation
import SwiftUI

public var coordinator: Coordinator?

public final class Coordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func heatMapColorSelectView() {
        path.append(HistoryNavigation(name: .heatMapColor))
    }
}
