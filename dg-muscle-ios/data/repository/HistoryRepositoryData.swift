//
//  HistoryRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

final class HistoryRepositoryData: HistoryRepository {
    static let shared = HistoryRepositoryData()
    
    var histories: [HistoryDomain] { _histories }
    var historiesPublisher: AnyPublisher<[HistoryDomain], Never> { $_histories.eraseToAnyPublisher() }
    @Published private var _histories: [HistoryDomain] = [] {
        didSet {
            try? FileManagerHelperV2.shared.save(histories.prefix(30).map({ HistoryData(from: $0) }), toFile: .history)
        }
    }
    
    var heatmapColor: HeatmapColorDomain { _heatmapColor }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { $_heatmapColor.eraseToAnyPublisher() }
    @Published var _heatmapColor: HeatmapColorDomain = .green
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        _histories = getExerciseHistoryFromFile()
        _heatmapColor = get()
        bind()
    }
    
    func post(data: HistoryDomain) async throws {
        if let index = histories.firstIndex(where: { $0.id == data.id }) {
            _histories[index] = data
        } else {
            _histories.insert(data, at: 0)
        }
        
        let historyDatas: [HistoryData] = histories.map({ .init(from: $0) })
        
        let _: ResponseData = try await APIClient.shared.request(
            method: .post,
            url: FunctionsURL.history(.posthistory),
            body: HistoryData(from: data)
        )
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
        
        let _: ResponseData = try await APIClient.shared.request(method: .delete,
                                                                 url: FunctionsURL.history(.deletehistory),
                                                                 body: body)
    }
    
    func post(data: HeatmapColorDomain) throws {
        _heatmapColor = data
        let data = HeatmapColorData(rawValue: data.rawValue) ?? .green
        try FileManagerHelperV2.shared.save(data, toFile: .heatmapColor)
    }
    
    private func get() -> HeatmapColorDomain {
        let data: HeatmapColorData = (try? FileManagerHelperV2.shared.load(HeatmapColorData.self, fromFile: .heatmapColor)) ?? .green
        return HeatmapColorDomain(rawValue: data.rawValue) ?? .green
    }
    
    private func getExerciseHistoryFromFile() -> [HistoryDomain] {
        let historyDatas: [HistoryData] = (try? FileManagerHelperV2.shared.load([HistoryData].self, fromFile: .history)) ?? []
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
    
    private func bind() {
        UserRepositoryData.shared
            .isLoginPublisher
            .receive(on: DispatchQueue.main)
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
}
