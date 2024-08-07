//
//  HistoryRepository.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine

public protocol HistoryRepository {
    var histories: AnyPublisher<[History], Never> { get }
    var runDistanceSubject: PassthroughSubject<Double, Never> { get }
    var runDurationSubject: PassthroughSubject<Int, Never> { get }
    var dateToSelectHistory: PassthroughSubject<Date, Never> { get }
    
    func get() -> [History]
    func get(historyId: String) -> History?
    func post(history: History) async throws
    func delete(history: History) async throws
}
