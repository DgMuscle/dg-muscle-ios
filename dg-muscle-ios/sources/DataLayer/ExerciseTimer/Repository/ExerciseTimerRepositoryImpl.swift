//
//  ExerciseTimerRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain
import Combine

public final class ExerciseTimerRepositoryImpl: ExerciseTimerRepository {
    public static let shared = ExerciseTimerRepositoryImpl()
    
    public var timer: AnyPublisher<Domain.ExerciseTimerDomain?, Never> { $_timer.eraseToAnyPublisher() }
    @Published var _timer: ExerciseTimerDomain?
    
    private init() {
        
    }
    
    public func post(timer: Domain.ExerciseTimerDomain) {
        _timer = timer
    }
    
    public func delete() {
        _timer = nil
    }
}
