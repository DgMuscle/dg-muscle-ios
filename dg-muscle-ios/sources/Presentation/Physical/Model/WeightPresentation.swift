//
//  WeightPresentation.swift
//  App
//
//  Created by Donggyu Shin on 7/26/24.
//

import Foundation
import Charts

struct WeightPresentation: Hashable {
    let date: Date
    let value: Double
    let unit: Unit
}

extension WeightPresentation {
    enum Unit {
        case kg
        case lbs
    }
}
