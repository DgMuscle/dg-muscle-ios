//
//  Unit.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

enum Unit: String, Codable {
    case kg
    case lbs
    
    var domain: Domain.Unit {
        switch self {
        case .kg: return .kg
        case .lbs: return .lbs
        }
    }
    
    init(domain: Domain.Unit) {
        switch domain {
        case .kg:
            self = .kg
        case .lbs:
            self = .lbs
        }
    }
}
