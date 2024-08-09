//
//  GetWeightsWithoutDuplicatesUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation

public class GetWeightsWithoutDuplicatesUsecase {
    public init() { }
    
    public func implement(weights: [WeightDomain]) -> [WeightDomain] {
        var results: [WeightDomain] = []
        var dates: Set<String> = []
        
        for weight in weights {
            if dates.contains(weight.yyyyMMdd) == false {
                dates.insert(weight.yyyyMMdd)
                results.append(weight)
            }
        }
        
        results = results.sorted(by: { $0.yyyyMMdd > $1.yyyyMMdd })
        
        return results
    }
}
