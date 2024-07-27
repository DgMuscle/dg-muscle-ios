//
//  TrainingMode.swift
//  DataLayer
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Domain

public enum TrainingMode: String, Codable {
    case mass
    case strength
    
    init(domain: Domain.TrainingMode) {
        switch domain {
        case .mass:
            self = .mass
        case .strength:
            self = .strength
        }
    }
    
    var domain: Domain.TrainingMode {
        switch self {
        case .mass:
            return .mass
        case .strength:
            return .strength
        }
    }
}
