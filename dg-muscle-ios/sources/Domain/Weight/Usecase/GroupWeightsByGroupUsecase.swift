//
//  GroupWeightsByGroupUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/7/24.
//

import Foundation

public final class GroupWeightsByGroupUsecase {
    public init() { }
    
    public func implement(weights: [WeightDomain]) -> [String: [WeightDomain]] {
        var result: [String: [WeightDomain]] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        
        for weight in weights {
            let dateString = dateFormatter.string(from: weight.date)
            result[dateString, default: []].append(weight)
        }
        
        return result
    }
}
