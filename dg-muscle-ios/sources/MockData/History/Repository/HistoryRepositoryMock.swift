//
//  HistoryRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

public final class HistoryRepositoryMock: HistoryRepository {
    public var histories: AnyPublisher<[Domain.History], Never> { $_histories.eraseToAnyPublisher() }
    @Published var _histories: [History]
    
    public var runDistanceSubject: PassthroughSubject<Double, Never> = .init()
    public var runDurationSubject: PassthroughSubject<Int, Never> = .init()
    public var dateToSelectHistory: PassthroughSubject<Date, Never> = .init()
    
    public init() {
        _histories = HISTORIES
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
            var histories = _histories
            histories.append(history)
            histories.sort(by: {$0.date > $1.date})
            _histories = histories
        }
    }
    
    public func delete(history: Domain.History) async throws {
        if let index = _histories.firstIndex(where: { $0.id == history.id }) {
            _histories.remove(at: index)
        }
    }
}
