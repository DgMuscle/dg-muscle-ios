//
//  Run.swift
//  History
//
//  Created by Donggyu Shin on 6/25/24.
//

import Foundation
import Domain

struct Run: Hashable {
    let duration: Int
    let distance: Double
    
    init(domain: Domain.Run) {
        self.duration = domain.duration
        self.distance = domain.distance
    }
    
    var domain: Domain.Run {
        .init(
            duration: duration,
            distance: distance
        )
    }
}
