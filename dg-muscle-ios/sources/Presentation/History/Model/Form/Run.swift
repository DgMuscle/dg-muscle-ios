//
//  Run.swift
//  History
//
//  Created by Donggyu Shin on 6/25/24.
//

import Foundation
import Domain

public struct RunPresentation: Hashable {
    public var duration: Int
    public var distance: Double
    
    init() {
        duration = 0
        distance = 0
    }
    
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
