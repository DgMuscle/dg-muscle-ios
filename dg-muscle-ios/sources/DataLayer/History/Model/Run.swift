//
//  Run.swift
//  DataLayer
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

struct Run: Codable {
    let id: String
    let pieces: [RunPiece]
    
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
