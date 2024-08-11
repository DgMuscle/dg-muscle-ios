//
//  ExerciseTimerRepository.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Combine

public protocol ExerciseTimerRepository {
    var timer: AnyPublisher<ExerciseTimerDomain?, Never> { get }
    
    func get() -> ExerciseTimerDomain?
    func post(timer: ExerciseTimerDomain)
    func delete()
}
