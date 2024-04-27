//
//  Height.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/5/23.
//

import Foundation

struct Height {
    let unit: Unit
    let value: Double
    let startDate: Date
}

extension Height {
    enum Unit {
        case centi
    }
}
