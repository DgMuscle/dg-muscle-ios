//
//  GetWeightsRangeUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation

public final class GetWeightsRangeUsecase {
    public init() { }
    
    public func implement(weights: [WeightDomain]) -> (Double, Double) {
        var result: (Double, Double) = (0, 0)
        
        guard var min = weights.map({ $0.value }).min() else { return result }
        guard var max = weights.map({ $0.value }).max() else { return result }
        
        min -= 1.1
        min = floor(min)
        max += 1.1
        max = ceil(max)
        
        result = (min, max)
        return result
    }
}
