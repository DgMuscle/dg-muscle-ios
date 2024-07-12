//
//  ExerciseCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/13/24.
//

import SwiftUI
import Domain

public final class ExerciseCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        _path = path
    }
    
    public func addExercise(exercise: Exercise?) {
        path.append(ExerciseNavigation(name: .add(exercise)))
    }
    
    public func exerciseManage() {
        path.append(ExerciseNavigation(name: .manage))
    }
}
