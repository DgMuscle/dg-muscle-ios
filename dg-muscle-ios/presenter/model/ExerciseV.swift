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
        self.parts = from.parts.compactMap({ .init(rawValue: $0.rawValue) })
        self.favorite = from.favorite
    }
    
    var domain: ExerciseDomain {
        .init(id: id, name: name, parts: parts.compactMap({ .init(rawValue: $0.rawValue) }), favorite: favorite)
    }
}

extension ExerciseV {
    enum Part: String {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
