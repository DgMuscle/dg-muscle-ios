//
//  ExerciseTimerPresentation.swift
//  DataLayer
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain

public struct ExerciseTimerPresentation: Equatable {
    public let id: String
    public let targetDate: Date
    
    var remainTime: String {
        let target = targetDate.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let diff = Int(target - now)
        return formatTime(seconds: diff)
    }
    
    public init(domain: ExerciseTimerDomain) {
        id = UUID().uuidString
        targetDate = domain.targetDate
    }
    
    public var domain: ExerciseTimerDomain {
        .init(targetDate: targetDate)
    }
    
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        // "%02d"는 두 자리의 숫자를 항상 표시하겠다는 의미로, 만약 한 자리 수일 경우 앞에 0을 추가합니다.
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}
