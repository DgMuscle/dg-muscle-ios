//
//  Exercise.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

struct Exercise: Codable, Identifiable, Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let parts: [Part]
    let favorite: Bool
    let order: Int
    let createdAt: CreatedAt?
}

extension Exercise {
    enum Part: String, Codable, CaseIterable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
