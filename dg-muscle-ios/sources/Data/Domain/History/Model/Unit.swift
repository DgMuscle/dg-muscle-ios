//
//  Unit.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

enum Unit: String, Codable {
    case kb
    case lbs
    
    var domain: Domain.Unit {
        switch self {
        case .kb: return .kb
        case .lbs: return .lbs
        }
    }
    
    init(domain: Domain.Unit) {
        switch domain {
        case .kb:
            self = .kb
        case .lbs:
            self = .lbs
        }
    }
}
