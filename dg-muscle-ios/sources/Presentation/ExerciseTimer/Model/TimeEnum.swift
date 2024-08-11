//
//  TimeEnum.swift
//  ExerciseTimer
//
//  Created by 신동규 on 8/11/24.
//

import Foundation

enum TimeEnum: String, CaseIterable, Hashable {
    case one = "1:00"
    case oneThirty = "1:30"
    case two = "2:00"
    case twoThirty = "2:30"
    case three = "3:00"
    
    var seconds: Int {
        switch self {
        case .one:
            return 60
        case .oneThirty:
            return 90
        case .two:
            return 120
        case .twoThirty:
            return 150
        case .three:
            return 180
        }
    }
}
