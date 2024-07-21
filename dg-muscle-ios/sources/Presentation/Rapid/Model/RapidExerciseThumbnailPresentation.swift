//
//  RapidExerciseThumbnailPresentation.swift
//  App
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain

struct RapidExerciseThumbnailPresentation {
    public let id: String
    public let name: String
    public let bodyPart: RapidBodyPartPresentation
    
    init(domain: Domain.RapidExerciseDomain) {
        id = domain.id
        name = domain.name
        bodyPart = .init(domain: domain.bodyPart) 
    }
}
