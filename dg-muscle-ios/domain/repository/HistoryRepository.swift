//
//  HistoryRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

protocol HistoryRepository {
    var histories: [HistoryDomain] { get }
    var historiesPublisher: AnyPublisher<[HistoryDomain], Never> { get }
    func get() throws -> [HeatmapDomain]
    func post(data: HistoryDomain) async throws
    func post(data: [HeatmapDomain]) throws
    func delete(data: HistoryDomain) async throws
}
