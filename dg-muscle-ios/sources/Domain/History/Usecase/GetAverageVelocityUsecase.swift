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
    /// distance / duration
    public func implement(run: Run) -> Double {
        run.distance / Double(run.duration)
    }
}
