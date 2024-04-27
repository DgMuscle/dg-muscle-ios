//
//  BodyMass.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/5/23.
//

import Foundation

struct BodyMass {
    let unit: Unit
    let value: Double
    let startDate: Date
}

extension BodyMass {
    enum Unit {
        case kg
        case lbs
    }
}
