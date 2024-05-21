//
//  Coordinator.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation
import SwiftUI
import Exercise

public var coordinator: Coordinator?

public final class Coordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func pop(_ k: Int = 1) {
        path.removeLast(k)
    }
    
    func addExercise(exercise: Exercise?) {
        path.append(ExerciseNavigation(name: .add(exercise)))
    }
    
    func exerciseManage() {
        path.append(ExerciseNavigation(name: .manage))
    }
    
    func heatMapColorSelectView() {
        path.append(HistoryNavigation(name: .heatMapColor))
    }
}
