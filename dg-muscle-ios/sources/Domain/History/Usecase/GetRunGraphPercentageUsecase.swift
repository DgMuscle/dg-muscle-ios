//
//  GetRunGraphPercentageUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/23/24.
//

import Foundation

public final class GetRunGraphPercentageUsecase {
    public init() { }
    
    public func implement(runPieces: [RunPiece]) -> Double {
        var result: Double = 0
        let totalDuration = Double(runPieces.map({ $0.duration }).reduce(0, +))
        let hour: Double = 3600
        
        result = totalDuration / hour
        result = min(result, 1)
        return result
    }
}
