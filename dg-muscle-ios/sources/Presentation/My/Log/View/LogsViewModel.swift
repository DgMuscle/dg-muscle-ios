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
    private let getUserFromUidUsecase: GetUserFromUidUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        logRepository: LogRepository,
        friendRepository: FriendRepository
    ) {
        resolveLogUsecase = .init(logRepository: logRepository)
        subscribeLogsUsecase = .init(logRepository: logRepository)
        getUserFromUidUsecase = .init(friendRepository: friendRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeLogsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] domainLogs in
                self?.configureLogs(logs: domainLogs)
            }
            .store(in: &cancellables)
    }
    
    private func configureLogs(logs domains: [Domain.DGLog]) {
        var logs: [DGLog] = domains.map({ .init(domain: $0) })
        
        logs = logs
            .map({ log in
                var log = log
                let user = getUserFromUidUsecase.implement(uid: log.creator)
                log.user = .init(displayName: user?.displayName ?? user?.uid ?? "", photoURL: user?.photoURL)
                return log
            })
        
        self.logs = logs
    }
}
