//
//  ExerciseDomain.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct ExerciseDomain {
    let id: String
    var name: String
    var parts: [Part]
    var favorite: Bool
}

extension ExerciseDomain {
    enum Part: Comparable {
        case arm
        case back
        case chest
        case core
        case leg
        case shoulder
    }
}
