//
//  HistoryRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine
import WidgetKit

final class HistoryRepositoryData: HistoryRepository {
    static let shared = HistoryRepositoryData()
    var histories: [HistoryDomain] { _histories }
    var historiesPublisher: AnyPublisher<[HistoryDomain], Never> { $_histories.eraseToAnyPublisher() }
    
    @Published private var _histories: [HistoryDomain] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        UserRepositoryData.shared.isLoginPublisher
            .removeDuplicates()
            .sink { login in
                if login {
                    Task {
                        self._histories = try await self.get(lastId: nil, limit: 365)
                    }
                } else {
                    self._histories = []
                }
            }
            .store(in: &cancellables)
    }
    
    func get() throws -> [HeatmapDomain] {
        let heatmapDatas: [HeatmapData] = try FileManagerHelperV2.shared.load([HeatmapData].self, fromFile: .workoutHeatMapDataV2)
        let heatmapDomains: [HeatmapDomain] = heatmapDatas.map({ .init(id: $0.id, week: $0.week, volumes: $0.volumes) })
        return heatmapDomains
    }
    
    func post(data: HistoryDomain) async throws {
        if let index = histories.firstIndex(where: { $0.id == data.id }) {
            _histories[index] = data
        } else {
            _histories.insert(data, at: 0)
        }
        
        let historyDatas: [HistoryData] = histories.map({ .init(from: $0) })
        
        try? FileManagerHelperV2.shared.save(historyDatas, toFile: .historyV2)
        
        let _: ResponseData = try await APIClient.shared.request(
            url: FunctionsURL.history(.posthistory),
            body: HistoryData(from: data)
        )
    }
    
    func post(data: [HeatmapDomain]) throws {
        let data: [HeatmapData] = data.map({ .init(from: $0) })
        try FileManagerHelperV2.shared.save(data, toFile: .workoutHeatMapDataV2)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func delete(data: HistoryDomain) async throws {
        struct Body: Codable {
            let id: String
        }
        let body = Body(id: data.id)
        
        if let index = _histories.firstIndex(where: { $0.id == data.id }) {
            _histories.remove(at: index)
        }
        
        let historyDatas: [HistoryData] = histories.map({ .init(from: $0) })
        try? FileManagerHelperV2.shared.save(historyDatas, toFile: .historyV2)
        
        let _: ResponseData = try await APIClient.shared.request(method: .delete,
                                                                 url: FunctionsURL.history(.deletehistory),
                                                                 body: body)
    }
    
    private func getExerciseHistoryFromFile() -> [HistoryDomain] {
        let historyDatas: [HistoryData] = (try? FileManagerHelperV2.shared.load([HistoryData].self, fromFile: .historyV2)) ?? []
        return historyDatas.map { $0.domain }
    }
    
    private func get(lastId: String?, limit: Int) async throws -> [HistoryDomain] {
        var url = "\(FunctionsURL.history(.gethistories))?limit=\(limit)"
        if let lastId {
            url = url + "&lastId=\(lastId)"
        }
        let historyDatas: [HistoryData] = try await APIClient.shared.request(url: url)
        try? FileManagerHelper.save(historyDatas, toFile: .history)
        return historyDatas.map { $0.domain }
    }
}
