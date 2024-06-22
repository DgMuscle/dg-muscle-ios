//
//  SubscribeLogsUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation
import Combine

public final class SubscribeLogsUsecase {
    private let logRepository: LogRepository
    
    public init(logRepository: LogRepository) {
        self.logRepository = logRepository
    }
    
    public func implement() -> AnyPublisher<[DGLog], Never> {
        logRepository.logs
    }
}
