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
    let status: Status
    
    var start: Date? {
        pieces.first?.start
    }
    
    var end: Date? {
        pieces.last?.end ?? pieces.last?.start
    }
    
    init(domain: Domain.Run) {
        id = domain.id
        pieces = domain.pieces.map({ .init(domain: $0) })
        status = .init(domain: domain.status)
    }
    
    var domain: Domain.Run {
        .init(
            id: id,
            pieces: pieces.map({ $0.domain }), status: status.domain
        )
    }
}

extension Run {
    enum Status {
        case running
        case notRunning
        
        var domain: Domain.Run.Status {
            switch self {
            case .running:
                return .running
            case .notRunning:
                return .notRunning
            }
        }
        
        init(domain: Domain.Run.Status) {
            switch domain {
            case .running:
                self = .running
            case .notRunning:
                self = .notRunning
            }
        }
    }
}
