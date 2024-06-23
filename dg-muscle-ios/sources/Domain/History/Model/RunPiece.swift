//
//  RunPiece.swift
//  Domain
//
//  Created by 신동규 on 6/15/24.
//

import Foundation

public struct RunPiece {
    public let id: String
    public let velocity: Double
    public let start: Date
    public let end: Date?
    
    var distance: Double {
        let timeInHours = Double(duration) / 3600.0
        return timeInHours * velocity
    }
    
    var duration: Int {
        guard let end else { return 0 }
        return Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
    }
    
    public init(
        id: String,
        velocity: Double,
        start: Date,
        end: Date?
    ) {
        self.id = id
        self.velocity = velocity
        self.start = start
        self.end = end
    }
}
