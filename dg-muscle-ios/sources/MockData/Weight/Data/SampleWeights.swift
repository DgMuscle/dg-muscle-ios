//
//  SampleWeights.swift
//  MockData
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Domain

func dateGenerator(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    return dateFormatter.date(from: string)!
}

public var WEIGHTS: [WeightDomain] = [
    .init(value: 70, unit: .kg, date: dateGenerator(string: "20240806")),
    .init(value: 69, unit: .kg, date: dateGenerator(string: "20240806")),
    .init(value: 65, unit: .kg, date: dateGenerator(string: "20240728")),
    .init(value: 66, unit: .kg, date: dateGenerator(string: "20240722")),
    .init(value: 68, unit: .kg, date: dateGenerator(string: "20240718")),
    .init(value: 65, unit: .kg, date: dateGenerator(string: "20240711")),
    .init(value: 64, unit: .kg, date: dateGenerator(string: "20240708")),
    .init(value: 64, unit: .kg, date: dateGenerator(string: "20240701")),
    .init(value: 63, unit: .kg, date: dateGenerator(string: "20240629")),
    .init(value: 64, unit: .kg, date: dateGenerator(string: "20240622")),
    .init(value: 65, unit: .kg, date: dateGenerator(string: "20240618")),
    .init(value: 63, unit: .kg, date: dateGenerator(string: "20240610")),
    .init(value: 62, unit: .kg, date: dateGenerator(string: "20240606")),
    .init(value: 63, unit: .kg, date: dateGenerator(string: "20240529")),
    .init(value: 63, unit: .kg, date: dateGenerator(string: "20240522")),
    .init(value: 62.5, unit: .kg, date: dateGenerator(string: "20240517")),
    .init(value: 63.2, unit: .kg, date: dateGenerator(string: "20240511")),
    .init(value: 60, unit: .kg, date: dateGenerator(string: "20240206")),
    .init(value: 61, unit: .kg, date: dateGenerator(string: "20240202")),
    .init(value: 61.3, unit: .kg, date: dateGenerator(string: "20240101")),
]
