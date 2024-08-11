//
//  ExerciseTimerMockData.swift
//  MockData
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain

public struct ExerciseTimerMockData: Codable {
    public let targetDate: Date
    
    public init(domain: ExerciseTimerDomain) {
        targetDate = domain.targetDate
    }
    
    public var domain: ExerciseTimerDomain {
        .init(targetDate: targetDate)
    }
}
