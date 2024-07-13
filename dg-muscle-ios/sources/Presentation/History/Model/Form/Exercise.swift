//
//  Exercise.swift
//  History
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Domain

public struct HistoryExercise: Hashable {
    public let id: String
    public let name: String
    public let favorite: Bool
    public let parts: [ExercisePart]
    
    public init(domain: Domain.Exercise) {
        self.id = domain.id
        self.name = domain.name
        self.favorite = domain.favorite
        self.parts = domain.parts.map({ .init(domain: $0) })
    }
    
    public var domain: Domain.Exercise {
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
