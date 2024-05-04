//
//  ExerciseNavigation.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct ExerciseNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case manage
        case edit
        case add1
        case add2
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var id: Int { name.hashValue }
    let name: Name
    var edit: ExerciseV? = nil
    var exerciseName: String? = nil
    var exerciseParts: [ExerciseV.Part] = []
    
    init(name: Name) {
        self.name = name
    }
    
    init(edit: ExerciseV) {
        name = .edit
        self.edit = edit
    }
    
    init(exerciseName: String, exerciseParts: [ExerciseV.Part]) {
        self.exerciseName = exerciseName
        self.exerciseParts = exerciseParts
        name = .add2
    }
}
