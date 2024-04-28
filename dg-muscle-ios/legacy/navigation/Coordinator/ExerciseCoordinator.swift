//
//  ExerciseCoordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import Foundation
import SwiftUI

final class ExerciseCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func manage() {
        let navigation = ExerciseNavigation(name: .manage)
        path.append(navigation)
    }
    
    func edit(exercise: Exercise) {
        let navigation = ExerciseNavigation(name: .edit,
                                            editIngredient: exercise)
        path.append(navigation)
    }
    
    func step1() {
        let navigation = ExerciseNavigation(name: .step1)
        path.append(navigation)
    }
    
    func step2(name: String, parts: [Exercise.Part]) {
        let dependency = ExerciseNavigation.Step2Dependency(name: name, 
                                                            parts: parts)
        let navigation = ExerciseNavigation(name: .step2,
                                            step2Depndency: dependency)
        path.append(navigation)
    }
}
