//
//  Exercise.swift
//  MockData
//
//  Created by 신동규 on 7/20/24.
//

import Foundation
import Domain

struct ExerciseMockData: Codable {
    let id: String
    let name: String
    let parts: [Part]
    let favorite: Bool
    
    init(domain: Domain.Exercise) {
        self.id = domain.id
        self.name = domain.name
        self.parts = domain.parts.map({ .init(domain: $0) })
        self.favorite = domain.favorite
    }
    
    var domain: Domain.Exercise {
        .init(id: id, name: name, parts: parts.map({ $0.domain }), favorite: favorite)
    }
}

extension ExerciseMockData {
    enum Part: String, Codable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
        
        init(domain: Domain.Exercise.Part) {
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
        
        var domain: Domain.Exercise.Part {
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

