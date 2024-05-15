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
    @Published var _histories: [Domain.History] = []
    
    private init() { }
}
