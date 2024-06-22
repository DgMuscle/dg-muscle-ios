//
//  LogRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 6/22/24.
//

import Combine
import Domain

public final class LogRepositoryImpl: LogRepository {
    public static let shared = LogRepositoryImpl()
    
    public var logs: AnyPublisher<[Domain.DGLog], Never> { $_logs.eraseToAnyPublisher() }
    @Published var _logs: [Domain.DGLog] = []
    
    private var postLogTask: Task<(), Never>? = nil
    private var fetchLogsTask: Task<(), Never>? = nil
    
    private init() { }
    
    public func post(log: Domain.DGLog) {
        if let index = _logs.firstIndex(where: { $0.id == log.id }) {
            _logs[index] = log
        } else {
            _logs.insert(log, at: 0)
        }
        
        guard postLogTask == nil else { return }
        postLogTask = Task {
            let log: DGLog = .init(domain: log)
            
            let _: DataResponse? = try? await APIClient.shared.request(
                method: .post,
                url: FunctionsURL.log(.postlog),
                body: log
            )
            
            postLogTask = nil
        }
    }
    
    public func resolve(id: String) {
        guard let index = _logs.firstIndex(where: { $0.id == id }) else { return }
        _logs[index].resolved.toggle()
        post(log: _logs[index])
    }
    
    private func fetchLogs() {
        guard fetchLogsTask == nil else { return }
        fetchLogsTask = Task {
            do {
                let logs: [DGLog] = try await APIClient.shared.request(
                    method: .get,
                    url: FunctionsURL.log(.getlogs)
                )
                
                self._logs = logs.map({ $0.domain })
            } catch {
                
            }
            
            fetchLogsTask = nil
        }
    }
}
