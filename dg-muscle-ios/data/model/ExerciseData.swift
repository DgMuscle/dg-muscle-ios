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
        parts = from.parts.compactMap({ .init(rawValue: $0.rawValue) })
        favorite = from.favorite
    }
    
    var domain: ExerciseDomain {
        .init(id: id, name: name, parts: parts.compactMap({ .init(rawValue: $0.rawValue) }), favorite: favorite)
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
