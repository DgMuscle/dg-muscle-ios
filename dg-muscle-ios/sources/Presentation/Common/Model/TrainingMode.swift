//
//  TrainingMode.swift
//  Common
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Domain

public enum TrainingMode {
    case mass
    case strength
    
    public init(domain: Domain.TrainingMode) {
        switch domain {
        case .mass:
            self = .mass
        case .strength:
            self = .strength
        }
    }
    
    public var domain: Domain.TrainingMode {
        switch self {
        case .mass:
            return .mass
        case .strength:
            return .strength
        }
    }
}
