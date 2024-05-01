//
//  HeightDomain.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HeightDomain {
    let unit: Unit
    let value: Double
    let startDate: Date
}

extension HeightDomain {
    enum Unit {
        case centi
    }
}
