//
//  ExercisePart.swift
//  Friend
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Domain

enum ExercisePart: String, CaseIterable {
    case arm
    case back
    case chest
    case core
    case leg
    case shoulder
    
    init(domain: Domain.Exercise.Part) {
        switch domain {
        case .arm:
            self = .arm
        case .back:
            self = .back
        case .chest:
            self = .chest
        case .core:
            self = .core
        case .leg:
            self = .leg
        case .shoulder:
            self = .shoulder
        }
    }
    
    var domain: Domain.Exercise.Part {
        switch self {
        case .arm:
            return .arm
        case .back:
            return .back
        case .chest:
            return .chest
        case .core:
            return .core
        case .leg:
            return .leg
        case .shoulder:
            return .shoulder
        }
    }
}
