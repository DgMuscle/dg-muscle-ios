//
//  RunPiece.swift
//  Presentation
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

struct RunPiece: Codable {
    let id: String
    let velocity: Double
    let start: TimeInterval?
    let end: TimeInterval?
    
    init(domain: Domain.RunPiece) {
        id = domain.id
        velocity = domain.velocity
        start = domain.start?.timeIntervalSince1970
        end = domain.end?.timeIntervalSince1970
    }
    
    var domain: Domain.RunPiece {
        
        var start: Date?
        var end: Date?
        
        if let timeInterval = self.start {
            start = .init(timeIntervalSince1970: timeInterval)
        }
        
        if let timeInterval = self.end {
            end = .init(timeIntervalSince1970: timeInterval)
        }
        
        return .init(
            id: id,
            velocity: velocity,
            start: start,
            end: end
        )
    }
}
