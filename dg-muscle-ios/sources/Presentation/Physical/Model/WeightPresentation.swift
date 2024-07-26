//
//  WeightPresentation.swift
//  App
//
//  Created by Donggyu Shin on 7/26/24.
//

import Foundation

struct WeightPresentation {
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
