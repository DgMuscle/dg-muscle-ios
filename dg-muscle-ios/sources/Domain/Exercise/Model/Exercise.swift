//
//  Exercise.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct Exercise: Hashable {
    public let id: String
    public let name: String
    public let parts: [Part]
    public let favorite: Bool
    
    public init(id: String, name: String, parts: [Part], favorite: Bool) {
        self.id = id
        self.name = name
        self.parts = parts
        self.favorite = favorite
    }
}

extension Exercise {
    public enum Part: CaseIterable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
