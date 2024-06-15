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
    
    public init(
        id: String,
        pieces: [RunPiece]
    ) {
        self.id = id
        self.pieces = pieces
    }
}
