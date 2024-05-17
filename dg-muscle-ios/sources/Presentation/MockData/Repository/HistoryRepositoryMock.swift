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
    @Published var _histories: [History] = [
        HISTORY_1, HISTORY_2, HISTORY_3
    ]    
    public init() { }
}
