//
//  UpdateRunVelocityUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public final class UpdateRunVelocityUsecase {
    private let runRepository: RunRepository
    
    public init(runRepository: RunRepository) {
        self.runRepository = runRepository
    }
    
    public func implement(velocity: Double) {
        runRepository.velocitySubject.send(velocity)
    }
}
