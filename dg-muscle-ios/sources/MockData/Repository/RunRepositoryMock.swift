//
//  RunRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 6/22/24.
//

import Domain
import Combine

public final class RunRepositoryMock: RunRepository {
    public var velocitySubject: PassthroughSubject<Double, Never> = .init()
    
    public init() { }
}
