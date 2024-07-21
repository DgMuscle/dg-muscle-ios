//
//  RapidRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine
import Domain

public final class RapidRepositoryImpl: RapidRepository {
    public static let shared = RapidRepositoryImpl()
    
    public var exercises: AnyPublisher<[Domain.RapidExerciseDomain], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published private var _exercises: [Domain.RapidExerciseDomain] = []
    
    public func get() -> [Domain.RapidExerciseDomain] {
        _exercises
    }
    
    private init() { }
    
    
}
