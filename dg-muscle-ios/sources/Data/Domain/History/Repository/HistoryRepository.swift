//
//  HistoryRepository.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

public final class HistoryRepository: Domain.HistoryRepository {
    public static let shared = HistoryRepository()
    public var histories: AnyPublisher<[Domain.History], Never> { $_histories.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    @Published var _histories: [Domain.History] = []
    
    private init() {
        bind()
    }
    
    private func bind() {
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.global(qos: .background))
            .sink { isLogin in
                if isLogin {
                    Task {
                        self._histories = await self.getMyHistoriesFromFilemanager()
                        self._histories = try await self.getMyHistoriesFromServer(lastId: nil, limit: 365)
                    }
                } else {
                    self._histories = []
                }
            }
            .store(in: &cancellables)
    }
    
    private func getMyHistoriesFromServer(lastId: String?, limit: Int) async throws -> [Domain.History] {
        var url = FunctionsURL.history(.gethistories)
        url.append("?limit=\(limit)")
        if let lastId {
            url.append("&lastId=\(lastId)")
        }
        let histories: [History] = try await APIClient.shared.request(url: url)
        return histories.map({ $0.domain })
    }
    
    private func getMyHistoriesFromFilemanager() async -> [Domain.History] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .background).async {
                let histories: [History] = (try? FileManagerHelper.shared.load([History].self, fromFile: .history)) ?? []
                continuation.resume(returning: histories.map({ $0.domain }))
            }
        }
    }
    
    private func postMyHistoriesToFileManager(histories: [Domain.History]) {
        DispatchQueue.global(qos: .background).async {
            let histories: [History] = histories.map({ .init(domain: $0) })
            try? FileManagerHelper.shared.save(histories, toFile: .history)
        }
    }
}
