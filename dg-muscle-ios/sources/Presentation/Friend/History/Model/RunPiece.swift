//
//  RunPiece.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

struct RunPiece: Hashable {
    let id: String
    let velocity: Double
    let start: Date
    let end: Date?
    
    init(domain: Domain.RunPiece) {
        id = domain.id
        velocity = domain.velocity
        start = domain.start
        end = domain.end
    }
    
    var domain: Domain.RunPiece {
        return .init(
            id: id,
            velocity: velocity,
            start: start,
            end: end
        )
    }
}
