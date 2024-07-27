//
//  RapidExerciseBodyPartPresentation.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain
import SwiftUI

public enum RapidBodyPartPresentation: String, CaseIterable {
    case back
    case cardio
    case chest
    case lowerArms = "lower arms"
    case lowerLegs = "lower legs"
    case neck
    case shoulders
    case upperArms = "upper arms"
    case upperLegs = "upper legs"
    case waist
    
    init(domain: Domain.RapidBodyPartDomain) {
        switch domain {
        case .back:
            self = .back
        case .cardio:
            self = .cardio
        case .chest:
            self = .chest
        case .lowerArms:
            self = .lowerArms
        case .lowerLegs:
            self = .lowerLegs
        case .neck:
            self = .neck
        case .shoulders:
            self = .shoulders
        case .upperArms:
            self = .upperArms
        case .upperLegs:
            self = .upperLegs
        case .waist:
            self = .waist
        }
    }
    
    var domain: Domain.RapidBodyPartDomain {
        switch self {
        case .back:
            return .back
        case .cardio:
            return .cardio
        case .chest:
            return .chest
        case .lowerArms:
            return .lowerArms
        case .lowerLegs:
            return .lowerLegs
        case .neck:
            return .neck
        case .shoulders:
            return .shoulders
        case .upperArms:
            return .upperArms
        case .upperLegs:
            return .upperLegs
        case .waist:
            return .waist
        }
    }
    
    var color: Color {
        switch self {
        case .back:
            return .accentColor
        case .cardio:
            return .green
        case .chest:
            return .red
        case .lowerArms:
            return .brown
        case .lowerLegs:
            return .indigo
        case .neck:
            return .mint
        case .shoulders:
            return .orange
        case .upperArms:
            return .purple
        case .upperLegs:
            return .brown
        case .waist:
            return .cyan
        }
    }
}
