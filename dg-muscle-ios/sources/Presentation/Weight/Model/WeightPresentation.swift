//
//  WeightPresentation.swift
//  Presentation
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Domain

struct WeightPresentation: Hashable {
    public let value: Double
    public let unit: Unit
    public let date: Date
    public let yyyyMMdd: String
    
    init(domain: Domain.WeightDomain) {
        value = domain.value
        unit = .init(domain: domain.unit)
        date = domain.date
        yyyyMMdd = domain.yyyyMMdd
    }
    
    var domain: Domain.WeightDomain {
        .init(
            value: value,
            unit: unit.domain,
            date: date
        )
    }
}

extension WeightPresentation {
    enum Unit: String {
        case kg
        case lbs
        
        init(domain: Domain.WeightDomain.Unit) {
            switch domain {
            case .kg:
                self = .kg
            case .lbs:
                self = .lbs
            }
        }
        
        var domain: Domain.WeightDomain.Unit {
            switch self {
            case .kg:
                return .kg
            case .lbs:
                return .lbs
            }
        }
    }
}
