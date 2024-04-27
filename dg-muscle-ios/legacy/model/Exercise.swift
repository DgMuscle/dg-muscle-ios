//
//  Exercise.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import SwiftUI

struct Exercise: Codable, Identifiable, Hashable, Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.parts == rhs.parts &&
        lhs.favorite == rhs.favorite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    var name: String
    var parts: [Part]
    var favorite: Bool
    var order: Int
    let createdAt: CreatedAt?
}

extension Exercise {
    enum Part: String, Codable, CaseIterable, Comparable {
        static func < (lhs: Exercise.Part, rhs: Exercise.Part) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
        
        var color: Color {
            switch self {
            case .arm:
                return .blue
            case .back:
                return .purple
            case .chest:
                return .cyan
            case .leg:
                return .mint
            case .shoulder:
                return .indigo
            case .core:
                return .green
            }
        }
    }
}
