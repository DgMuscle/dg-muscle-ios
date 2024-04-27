//
//  HeightData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HeightData {
    let unit: Unit
    let value: Double
    let startDate: Date
}

extension HeightData {
    enum Unit {
        case centi
    }
}
