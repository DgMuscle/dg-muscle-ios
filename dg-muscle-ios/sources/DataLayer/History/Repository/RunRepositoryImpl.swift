//
//  RunRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 6/22/24.
//

import Combine
import Domain

final class RunRepositoryImpl: RunRepository {
    var velocitySubject: PassthroughSubject<Double, Never> = .init()
}
