//
//  BodyMassData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct BodyMassData {
    let unit: Unit
    let value: Double
    let startDate: Date
    
    init(unit: Unit, value: Double, startDate: Date) {
        self.unit = unit
        self.value = value
        self.startDate = startDate
    }
    
    init(from: BodyMassDomain) {
        unit = .init(rawValue: from.unit.rawValue) ?? .kg
        value = from.value
        startDate = from.startDate
    }
    
    var domain: BodyMassDomain {
        .init(unit: .init(rawValue: unit.rawValue) ?? .kg, value: value, startDate: startDate)
    }
}

extension BodyMassData {
    enum Unit: String {
        case kg
        case lbs
    }
}
