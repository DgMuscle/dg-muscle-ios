//
//  SubscribeRunVelocityUpdatesUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Combine

public final class SubscribeRunVelocityUpdatesUsecase {
    private let runRepository: RunRepository
    
    public init(runRepository: RunRepository) {
        self.runRepository = runRepository
    }
    
    public func implement() -> PassthroughSubject<Double, Never> {
        return runRepository.velocitySubject
    }
}
