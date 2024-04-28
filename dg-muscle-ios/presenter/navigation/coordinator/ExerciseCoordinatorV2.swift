//
//  ExerciseCoordinatorV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

final class ExerciseCoordinatorV2 {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func manage() {
        path.append(ExerciseNavigationV2(name: .manage))
    }
    
    func add1() {
        path.append(ExerciseNavigationV2(name: .add1))
    }
    
    func add2(exerciseName: String, exerciseParts: [ExerciseV.Part]) {
        path.append(ExerciseNavigationV2(exerciseName: exerciseName, exerciseParts: exerciseParts))
    }
    
    func edit(exercise: ExerciseV) {
        path.append(ExerciseNavigationV2(edit: exercise))
    }
}
