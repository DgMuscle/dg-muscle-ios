//
//  RunRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 6/22/24.
//

import Combine
import Domain

public final class RunRepositoryImpl: RunRepository {
    public static let shared = RunRepositoryImpl()
    
    public var velocitySubject: PassthroughSubject<Double, Never> = .init()
    
    private init() { }
}
