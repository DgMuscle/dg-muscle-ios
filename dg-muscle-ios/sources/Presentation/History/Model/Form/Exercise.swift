//
//  Exercise.swift
//  History
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Domain

struct Exercise: Hashable {
    let id: String
    let name: String
    let favorite: Bool
    let parts: [ExercisePart]
    
    init(domain: Domain.Exercise) {
        self.id = domain.id
        self.name = domain.name
        self.favorite = domain.favorite
        self.parts = domain.parts.map({ .init(domain: $0) })
    }
    
    var domain: Domain.Exercise {
        .init(
            id: id,
            name: name,
            parts: parts.map({
                $0.domain
            }),
            favorite: favorite
        )
    }
}
