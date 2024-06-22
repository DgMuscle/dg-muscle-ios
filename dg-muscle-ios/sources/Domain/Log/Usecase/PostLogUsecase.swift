//
//  PostLogUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public final class PostLogUsecase {
    private let logRepository: LogRepository
    
    public init(logRepository: LogRepository) {
        self.logRepository = logRepository
    }
    
    public func implement(log: DGLog) {
        logRepository.post(log: log)
    }
}
