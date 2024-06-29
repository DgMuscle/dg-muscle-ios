//
//  GetAverageVelocityUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/26/24.
//

import Foundation

public final class GetAverageVelocityUsecase {
    public init() { }
    
    /// velocity
    /// distance / hour
    public func implement(run: Run) -> Double {
        guard run.duration > 0 else { return 0 }
        return run.distance / (Double(run.duration) / 3600) / 1000
    }
}
