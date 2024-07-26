//
//  RapidExercisePresentation.swift
//  Rapid
//
//  Created by 신동규 on 7/26/24.
//

import Foundation
import Domain

struct RapidExercisePresentation {
    let bodyPart: RapidBodyPartPresentation
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
    
    init(domain: Domain.RapidExerciseDomain) {
        self.bodyPart = .init(domain: domain.bodyPart)
        self.equipment = domain.equipment
        self.gifUrl = domain.gifUrl
        self.id = domain.id
        self.name = domain.name
        self.target = domain.target
        self.secondaryMuscles = domain.secondaryMuscles
        self.instructions = domain.instructions
    }
    
    var domain: Domain.RapidExerciseDomain {
        .init(
            bodyPart: bodyPart.domain,
            equipment: equipment,
            gifUrl: gifUrl,
            id: id,
            name: name,
            target: target,
            secondaryMuscles: secondaryMuscles,
            instructions: instructions
        )
    }
}
