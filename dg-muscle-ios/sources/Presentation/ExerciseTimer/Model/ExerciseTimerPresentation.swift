//
//  ExerciseTimerPresentation.swift
//  DataLayer
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain

struct ExerciseTimerPresentation {
    let targetDate: Date
    
    init(domain: ExerciseTimerDomain) {
        targetDate = domain.targetDate
    }
    
    var domain: ExerciseTimerDomain {
        .init(targetDate: targetDate)
    }
}
