//
//  ExerciseTimerData.swift
//  DataLayer
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain

public struct ExerciseTimerData: Codable {
    public let targetDate: Date
    var isValid: Bool {
        targetDate > Date()
    }
    
    public init(domain: ExerciseTimerDomain) {
        targetDate = domain.targetDate
    }
    
    public var domain: ExerciseTimerDomain {
        .init(targetDate: targetDate)
    }
}
