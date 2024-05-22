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
    
    func post(history: History) async throws
}
