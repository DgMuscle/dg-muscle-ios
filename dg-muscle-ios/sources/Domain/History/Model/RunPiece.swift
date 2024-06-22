//
//  RunPiece.swift
//  Domain
//
//  Created by 신동규 on 6/15/24.
//

import Foundation

public struct RunPiece {
    public let id: String
    public let velocity: Double
    public let start: Date?
    public let end: Date?
    
    public init(
        id: String,
        velocity: Double,
        start: Date?,
        end: Date?
    ) {
        self.id = id
        self.velocity = velocity
        self.start = start
        self.end = end
    }
}
