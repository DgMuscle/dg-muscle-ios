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
}

extension WeightPresentation {
    enum Unit {
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
    }
}
