//
//  SubscribeLogBadgeUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Combine

public final class SubscribeLogBadgeUsecase {
    
    @Published var hasBadge: Bool = false
    
    private let logRepository: LogRepository
    private var cancellables = Set<AnyCancellable>()
    
    public init(logRepository: LogRepository) {
        self.logRepository = logRepository
        bind()
    }
    
    public func implement() -> AnyPublisher<Bool, Never> {
        $hasBadge.eraseToAnyPublisher()
    }
    
    private func bind() {
        logRepository
            .logs
            .map({$0.filter({ $0.resolved == false })})
            .map({ !$0.isEmpty })
            .sink { [weak self] hasUnresolved in
                self?.hasBadge = hasUnresolved
            }
            .store(in: &cancellables)
    }
}
