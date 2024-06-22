//
//  RunRepository.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Combine

public protocol RunRepository {
    var velocitySubject: PassthroughSubject<Double, Never> { get }
}
