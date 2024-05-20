//
//  ExerciseNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/19/24.
//

import Foundation

public struct ExerciseNavigation: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.rawValue.hashValue)
    }
    
    public init(name: Name) {
        self.name = name
    }
    
    let name: Name
}

extension ExerciseNavigation {
    public enum Name: String {
        case manage
    }
}
