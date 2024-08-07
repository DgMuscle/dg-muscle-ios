//
//  WeightRepository.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Combine

public protocol WeightRepository {
    var weights: AnyPublisher<[WeightDomain], Never> { get }
    
    func get() -> [WeightDomain]
    func post(weight: WeightDomain)
}
