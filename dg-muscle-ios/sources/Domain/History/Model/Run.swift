//
//  Run.swift
//  Domain
//
//  Created by 신동규 on 6/15/24.
//

import Foundation

public struct Run {
    public let id: String
    public let pieces: [RunPiece]
    public var status: Status
    
    public init(
        id: String,
        pieces: [RunPiece],
        status: Status
    ) {
        self.id = id
        self.pieces = pieces
        self.status = status
    }
}

extension Run {
    public enum Status {
        case running
        case notRunning
    }
}
