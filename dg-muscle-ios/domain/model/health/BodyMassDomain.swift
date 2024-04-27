//
//  BodyMassDomain.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct BodyMassDomain {
    let unit: Unit
    let value: Double
    let startDate: Date
}

extension BodyMassDomain {
    enum Unit: String {
        case kg
        case lbs
    }
}
