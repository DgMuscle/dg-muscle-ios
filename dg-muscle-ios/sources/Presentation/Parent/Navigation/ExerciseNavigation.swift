//
//  ExerciseNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/19/24.
//

import Foundation

struct ExerciseNavigation: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.rawValue.hashValue)
    }
    
    let name: Name
}

extension ExerciseNavigation {
    enum Name: String {
        case manage
    }
}
