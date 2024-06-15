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
    public var start: Date?
    public var end: Date?
    
    var duration: Int {
        guard let start else { return 0 }
        let end = end ?? Date()
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
