//
//  WeightSection.swift
//  Weight
//
//  Created by Donggyu Shin on 8/7/24.
//

import Foundation

struct WeightSection: Hashable {
    let yyyyMM: String
    let weights: [WeightPresentation]
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter.date(from: yyyyMM) ?? Date()
    }
}
