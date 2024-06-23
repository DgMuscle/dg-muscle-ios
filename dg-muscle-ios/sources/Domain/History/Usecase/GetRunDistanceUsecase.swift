//
//  GetRunDistanceUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/23/24.
//

import Foundation

public final class GetRunDistanceUsecase {
    public init() { }
    
    public func implement(runPieces: [RunPiece]) -> String {
        return String(format: "%.2f", runPieces.map({ $0.distance }).reduce(0, +)) + " km"
    }
}
