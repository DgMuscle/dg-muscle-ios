//
//  Exercise.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public struct Exercise: Hashable {
    let id: String
    var name: String
    var parts: [Part]
    var favorite: Bool
    var popularity: Double = 0 
    
    init() {
        self.id = UUID().uuidString
        self.name = ""
        self.parts = []
        self.favorite = false
    }
    
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
    public enum Part: String, CaseIterable {
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
