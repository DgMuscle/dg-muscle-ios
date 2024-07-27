//
//  RapidBodyPartMockData.swift
//  MockData
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain

enum RapidBodyPartMockData: String, Codable {
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
}
