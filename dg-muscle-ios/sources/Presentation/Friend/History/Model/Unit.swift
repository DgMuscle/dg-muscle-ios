//
//  Unit.swift
//  Friend
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

enum Unit: String {
    case kg
    case lbs
    
    init(domain: Domain.Unit) {
        switch domain {
        case .kg: self = .kg
        case .lbs: self = .lbs
        }
    }
    
    var domain: Domain.Unit {
        switch self {
        case .kg: return .kg
        case .lbs: return .lbs
        }
    }
}
