//
//  RunPiece.swift
//  Presentation
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

public struct RunPiece: Hashable {
    public let id: String
    public var velocity: Double
    public var start: Date
    public var end: Date?
    
    var distance: Double {
        let timeInHours = Double(duration) / 3600.0
        return timeInHours * velocity
    }
    
    var duration: Int {
        guard let end else { return 0 }
        return Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
    }
    
    public init(velocity: Double, start: Date) {
        id = UUID().uuidString
        self.velocity = velocity
        self.start = start
        self.end = nil
    }
    
    public init(domain: Domain.RunPiece) {
        id = domain.id
        velocity = domain.velocity
        start = domain.start
        end = domain.end
    }
    
    public var domain: Domain.RunPiece {
        return .init(
            id: id,
            velocity: velocity,
            start: start,
            end: end
        )
    }
}
