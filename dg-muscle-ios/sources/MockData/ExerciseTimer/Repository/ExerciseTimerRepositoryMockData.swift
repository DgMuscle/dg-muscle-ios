//
//  ExerciseTimerRepositoryMockData.swift
//  MockData
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain
import Combine

public final class ExerciseTimerRepositoryMockData: ExerciseTimerRepository {
    public var timer: AnyPublisher<Domain.ExerciseTimerDomain?, Never> { $_timer.eraseToAnyPublisher() }
    @Published var _timer: ExerciseTimerDomain?
    
    public init() {
        
    }
    
    public func post(timer: Domain.ExerciseTimerDomain) {
        _timer = timer
    }
    
    public func delete() {
        _timer = nil
    }
}
