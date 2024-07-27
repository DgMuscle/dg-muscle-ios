//
//  LogRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 6/22/24.
//

import Combine
import Domain

public final class LogRepositoryMock: LogRepository {
    public var logs: AnyPublisher<[Domain.DGLog], Never> { $_logs.eraseToAnyPublisher() }
    @Published var _logs: [Domain.DGLog] = LOGS
    
    public init() { }
    
    public func post(log: Domain.DGLog) {
        if let index = _logs.firstIndex(where: { $0.id == log.id }) {
            _logs[index] = log
        } else {
            _logs.insert(log, at: 0)
        }
    }
    
    public func resolve(id: String) {
        if let index = _logs.firstIndex(where: { $0.id == id }) {
            _logs[index].resolved.toggle()
        }
    }
}
