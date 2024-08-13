//
//  WeightRepositoryMock.swift
//  MockData
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Domain
import Combine

public final class WeightRepositoryMock: WeightRepository {
    public var weights: AnyPublisher<[Domain.WeightDomain], Never> { $_weights.eraseToAnyPublisher() }
    @Published var _weights: [WeightDomain] = []
    
    public init() {
        _weights = WEIGHTS
    }
    
    public func get() -> [Domain.WeightDomain] {
        _weights
    }
    
    public func post(weight: Domain.WeightDomain) {
        _weights.append(weight)
    }
    
    public func delete(weight: Domain.WeightDomain) {
        guard let removeIndex = _weights.firstIndex(where: { $0.date == weight.date && $0.value == weight.value }) else { return }
        _weights.remove(at: removeIndex)
    }
}
