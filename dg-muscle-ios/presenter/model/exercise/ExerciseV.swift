//
//  ExerciseV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct ExerciseV: Equatable, Identifiable {
    let id: String
    var name: String
    var parts: [Part]
    var favorite: Bool
    
    init(id: String, name: String, parts: [Part], favorite: Bool) {
        self.id = id
        self.name = name
        self.parts = parts
        self.favorite = favorite
    }
    
    init(from: ExerciseDomain) {
        self.id = from.id
        self.name = from.name
        self.parts = from.parts.map({ Self.convertPart(part: $0) })
        self.favorite = from.favorite
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

extension ExerciseV {
    enum Part: String, CaseIterable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
