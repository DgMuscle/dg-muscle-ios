//
//  Exercise.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public struct Exercise: Hashable {
    public let id: String
    public let name: String
    public let parts: [Part]
    public let favorite: Bool
    
    public init(domain: Domain.Exercise) {
        self.id = domain.id
        self.name = domain.name
        self.parts = domain.parts.map({ .init(domain: $0) })
        self.favorite = domain.favorite
    }
    
    public var domain: Domain.Exercise {
        return .init(id: id, name: name, parts: parts.map({ $0.domain }), favorite: favorite)
    }
    
}

extension Exercise {
    public enum Part: String {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
        
        public init(domain: Domain.Exercise.Part) {
            switch domain {
            case .arm:
                self = .arm
            case .back:
                self = .back
            case .chest:
                self = .chest
            case .core:
                self = .core
            case .leg:
                self = .leg
            case .shoulder:
                self = .shoulder
            }
        }
        
        public var domain: Domain.Exercise.Part {
            switch self {
            case .arm:
                return .arm
            case .back:
                return .back
            case .chest:
                return .chest
            case .core:
                return .core
            case .leg:
                return .leg
            case .shoulder:
                return .shoulder
            }
        }
    }
}
