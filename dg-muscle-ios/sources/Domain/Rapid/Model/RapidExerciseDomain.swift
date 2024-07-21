//
//  RapidExerciseDomain.swift
//  Domain
//
//  Created by 신동규 on 7/21/24.
//

import Foundation

public struct RapidExerciseDomain {
    public let bodyPart: RapidBodyPartDomain
    public let equipment: String
    public let gifUrl: String
    public let id: String
    public let name: String
    public let target: String
    public let secondaryMuscles: [String]
    public let instructions: [String]
    
    public init(
        bodyPart: RapidBodyPartDomain,
        equipment: String,
        gifUrl: String,
        id: String,
        name: String,
        target: String,
        secondaryMuscles: [String],
        instructions: [String]
    ) {
        self.bodyPart = bodyPart
        self.equipment = equipment
        self.gifUrl = gifUrl
        self.id = id
        self.name = name
        self.target = target
        self.secondaryMuscles = secondaryMuscles
        self.instructions = instructions
    }
}
