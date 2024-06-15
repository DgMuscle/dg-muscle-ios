//
//  Run.swift
//  Presentation
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain

public struct RunPresentation: Hashable {
    public let id: String
    public var pieces: [RunPiece]
    
    var start: Date? {
        pieces.first?.start
    }
    
    var end: Date? {
        pieces.last?.end ?? pieces.last?.start
    }
    
    var duration: Int {
        pieces.map({ $0.duration }).reduce(0, +)
    }
    
    public init() {
        id = UUID().uuidString
        pieces = []
    }
    
    public init(domain: Domain.Run) {
        id = domain.id
        pieces = domain.pieces.map({ .init(domain: $0) })
    }
    
    public var domain: Domain.Run {
        .init(
            id: id,
            pieces: pieces.map({ $0.domain })
        )
    }
}
