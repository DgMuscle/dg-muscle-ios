//
//  Run.swift
//  Domain
//
//  Created by Donggyu Shin on 6/25/24.
//

import Foundation

public struct Run {
    public let duration: Int
    public let distance: Double
    
    public init(
        duration: Int,
        distance: Double
    ) {
        self.duration = duration
        self.distance = distance
    }
}
