//
//  Run.swift
//  History
//
//  Created by Donggyu Shin on 6/25/24.
//

import Foundation
import Domain

public struct Run: Hashable {
    public var duration: Int
    public var distance: Double
    
    public init(domain: Domain.Run) {
        self.duration = domain.duration
        self.distance = domain.distance
    }
    
    public var domain: Domain.Run {
        .init(
            duration: duration,
            distance: distance
        )
    }
}
