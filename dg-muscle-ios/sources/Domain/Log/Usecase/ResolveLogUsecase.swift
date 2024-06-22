//
//  ResolveLogUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public final class ResolveLogUsecase {
    private let logRepository: LogRepository
    
    public init(logRepository: LogRepository) {
        self.logRepository = logRepository
    }
    
    public func implement(id: String) {
        logRepository.resolve(id: id)
    }
}
