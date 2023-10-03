//
//  Exercise.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

struct Exercise: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let name: String
    let parts: [Part]
    let favorite: Bool
    var order: Int
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
