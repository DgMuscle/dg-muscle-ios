//
//  WeightRepositoryImpl.swift
//  App
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Combine
import Domain

public final class WeightRepositoryImpl: WeightRepository {
    public var weights: AnyPublisher<[Domain.WeightDomain], Never> { $_weights.eraseToAnyPublisher() }
    @Published var _weights: [Domain.WeightDomain] = []
    
    public init() {
        
    }
    
    public func get() -> [Domain.WeightDomain] {
        _weights
    }
}
