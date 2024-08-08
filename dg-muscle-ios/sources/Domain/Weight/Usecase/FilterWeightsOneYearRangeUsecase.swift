//
//  FilterWeightsOneYearRangeUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/8/24.
//

import Foundation

public final class FilterWeightsOneYearRangeUsecase {
    
    public init() { }
    
    public func implement(weights: [WeightDomain]) -> [WeightDomain] {
        var result = weights
            .sorted(by: { $0.date < $1.date })
        
        guard let maxDate = weights.map({ $0.date }).max() else { return result }
        let calendar = Calendar(identifier: .gregorian)
        guard let minDate = calendar.date(byAdding: .year, value: -1, to: maxDate) else { return result }
        
        result = result
            .filter({ $0.date >= minDate })
        
        return result
    }
}
