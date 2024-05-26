//
//  HistoryRepositoryImpl.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

public final class HistoryRepositoryImpl: Domain.HistoryRepository {
    public static let shared = HistoryRepositoryImpl()
    public var histories: AnyPublisher<[Domain.History], Never> { $_histories.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    @Published var _histories: [Domain.History] = [] {
        didSet {
            postMyHistoriesToFileManager(histories: _histories)
        }
    }
    
    private init() {
        bind()
    }
    
    public func get() -> [Domain.History] {
        _histories
    }
    
    public func get(historyId: String) -> Domain.History? {
        _histories.first(where: { $0.id == historyId })
    }
    
    public func post(history: Domain.History) async throws {
        if let index = _histories.firstIndex(where: { $0.id == history.id }) {
            _histories[index] = history
        } else {
            _histories.insert(history, at: 0)
        }
        
        let url = FunctionsURL.history(.posthistory)
        let data: History = .init(domain: history)
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: data
        )
    }
    
    public func delete(history: Domain.History) async throws {
        
        if let index = _histories.firstIndex(where: { $0.id == history.id }) {
            _histories.remove(at: index)
        }
        
        struct Body: Codable {
            let id: String
        }
        let url = FunctionsURL.history(.deletehistory)
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: Body(id: history.id)
        )
    }
    
    private func bind() {
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
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