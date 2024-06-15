//
//  Run.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

struct Run {
    let id: String
    let pieces: [RunPiece]
    
    var start: Date? {
        pieces.first?.start
    }
    
    var end: Date? {
        pieces.last?.end ?? pieces.last?.start
    }
    
    init(domain: Domain.Run) {
        id = domain.id
        pieces = domain.pieces.map({ .init(domain: $0) })
    }
    
    var domain: Domain.Run {
        .init(
            id: id,
            pieces: pieces.map({ $0.domain })
        )
    }
}
