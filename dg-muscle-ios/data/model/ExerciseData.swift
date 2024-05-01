//
//  ExerciseData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct ExerciseData: Codable {
    let id: String
    var name: String
    var parts: [Part]
    var favorite: Bool
    
    init(from: ExerciseDomain) {
        id = from.id
        name = from.name
        favorite = from.favorite
        parts = from.parts.map({ Self.convertPart(part: $0) })
    }
    
    var domain: ExerciseDomain {
        .init(id: id, name: name, parts: parts.map({ Self.convertPart(part: $0) }), favorite: favorite)
    }
    
    static func convertPart(part: Part) -> ExerciseDomain.Part {
        switch part {
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
 
    static func convertPart(part: ExerciseDomain.Part) -> Part {
        switch part {
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

extension ExerciseData {
    enum Part: String, Codable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
