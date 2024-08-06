//
//  WeightDomain.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation

public struct WeightDomain {
    public let value: Double
    public let unit: Unit
    public let date: Date
    public let yyyyMMdd: String
    
    public init(value: Double, unit: Unit, date: Date) {
        self.value = value
        self.unit = unit
        self.date = date
        
        let dateFormatter = DateFormatter()
        
        self.yyyyMMdd = dateFormatter.string(from: date)
    }
}

extension WeightDomain {
    public enum Unit {
        case kg
        case lbs
    }
}
