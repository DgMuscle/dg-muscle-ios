//
//  SearchWeightFromDateUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/6/24.
//

import Foundation

public class SearchWeightFromDateUsecase {
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
    }
    
    public func implement(date: Date) -> WeightDomain? {
        
        let weights = weightRepository.get()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        for i in (0..<6) {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: date) {
                let dateString = dateFormatter.string(from: date)
                if let weight = weights.first(where: { $0.yyyyMMdd == dateString }) {
                    return weight
                }
            }
            
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: date) {
                let dateString = dateFormatter.string(from: date)
                if let weight = weights.first(where: { $0.yyyyMMdd == dateString }) {
                    return weight
                }
            }
        }
        
        return nil
    }
}
