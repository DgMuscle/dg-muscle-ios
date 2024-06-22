//
//  SubscribeLogsUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation
import Combine

public final class SubscribeLogsUsecase {
    
    @Published var logs: [DGLog] = []
    
    private let logRepository: LogRepository
    private var cancellables = Set<AnyCancellable>()
    
    public init(logRepository: LogRepository) {
        self.logRepository = logRepository
        bind()
    }
    
    public func implement() -> AnyPublisher<[DGLog], Never> {
        $logs.eraseToAnyPublisher()
    }
    
    private func bind() {
        logRepository
            .logs
            .sink { [weak self] logs in
                self?.logs = logs
            }
            .store(in: &cancellables)
    }
}
