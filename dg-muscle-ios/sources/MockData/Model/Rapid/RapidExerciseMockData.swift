//
//  RapidExerciseMockData.swift
//  MockData
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain

struct RapidExerciseMockData: Codable {
    let bodyPart: RapidBodyPartMockData?
    let equipment: String?
    let gifUrl: String?
    let id: String?
    let name: String?
    let target: String?
    let secondaryMuscles: [String]?
    let instructions: [String]?
    
    init(domain: Domain.RapidExerciseDomain) {
        bodyPart = .init(domain: domain.bodyPart)
        equipment = domain.equipment
        gifUrl = domain.gifUrl
        id = domain.id
        name = domain.name
        target = domain.target
        secondaryMuscles = domain.secondaryMuscles
        instructions = domain.instructions
    }
    
    var domain: Domain.RapidExerciseDomain? {
        guard let bodyPart,
              let equipment,
              let gifUrl,
              let id,
              let name,
              let target,
              let secondaryMuscles,
              let instructions else { return nil }
        
        return Domain.RapidExerciseDomain(
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
