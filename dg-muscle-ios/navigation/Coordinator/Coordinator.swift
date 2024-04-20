//
//  Coordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import SwiftUI

final class Coordinator: ObservableObject {
    
    @Binding var path: NavigationPath
    
    lazy var exercise = ExerciseCoordinator(path: $path)
    lazy var history = HistoryCoordinator(path: $path)
    lazy var main = MainCoordinator(path: $path)
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
}
