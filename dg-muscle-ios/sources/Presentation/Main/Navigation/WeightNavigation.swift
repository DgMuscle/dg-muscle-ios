//
//  WeightNavigation.swift
//  Weight
//
//  Created by Donggyu Shin on 8/7/24.
//

import Foundation

public struct WeightNavigation: Hashable {
    let id = UUID().uuidString
    let name: Name
}

extension WeightNavigation {
    public enum Name {
        case weightList
    }
}
