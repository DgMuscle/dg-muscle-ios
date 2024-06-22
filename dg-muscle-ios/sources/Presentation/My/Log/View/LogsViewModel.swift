//
//  LogsViewModel.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import Foundation
import Combine
import Domain

final class LogsViewModel: ObservableObject {
    
    @Published var logs: [DGLog] = []
    
    private let resolveLogUsecase: ResolveLogUsecase
    private let subscribeLogsUsecase: SubscribeLogsUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(logRepository: LogRepository) {
        resolveLogUsecase = .init(logRepository: logRepository)
        subscribeLogsUsecase = .init(logRepository: logRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeLogsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] domainLogs in
                self?.logs = domainLogs.map({ .init(domain: $0) })
            }
            .store(in: &cancellables)
    }
}
