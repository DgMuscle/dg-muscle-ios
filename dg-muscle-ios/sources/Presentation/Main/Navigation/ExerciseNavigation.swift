//
//  ExerciseNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/19/24.
//

import Foundation
import Domain

public struct ExerciseNavigation: Hashable {
    public static func == (lhs: ExerciseNavigation, rhs: ExerciseNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public init(name: Name) {
        self.name = name
    }
    
    let id = UUID().uuidString
    let name: Name
}

extension ExerciseNavigation {
    public enum Name {
        case manage
        case add(Exercise?)
    }
}
