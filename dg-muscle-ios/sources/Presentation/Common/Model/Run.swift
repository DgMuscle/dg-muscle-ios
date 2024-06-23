//
//  Run.swift
//  Common
//
//  Created by 신동규 on 6/23/24.
//

import Foundation
import Domain

public struct RunPresentation: Hashable {
    public let id: String
    public var pieces: [RunPiece]
    public var status: Status
    
    public var distance: Double {
        pieces.map({ $0.distance }).reduce(0, +)
    }
    
    public init() {
        id = UUID().uuidString
        pieces = []
        status = .notRunning
    }
    
    public init(domain: Domain.Run) {
        id = domain.id
        pieces = domain.pieces.map({ .init(domain: $0) })
        status = .init(domain: domain.status)
    }
    
    public var domain: Domain.Run {
        .init(
            id: id,
            pieces: pieces.map({ $0.domain }), status: status.domain
        )
    }
}

extension RunPresentation {
    public enum Status {
        case running
        case notRunning
        
        public var domain: Domain.Run.Status {
            switch self {
            case .running:
                return .running
            case .notRunning:
                return .notRunning
            }
        }
        
        public init(domain: Domain.Run.Status) {
            switch domain {
            case .running:
                self = .running
            case .notRunning:
                self = .notRunning
            }
        }
    }
}

