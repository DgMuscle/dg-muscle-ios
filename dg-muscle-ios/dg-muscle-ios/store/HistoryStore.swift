//
//  HistoryStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Combine
import Foundation
import SwiftUI

final class HistoryStore: ObservableObject {
    static let shared = HistoryStore()
    
    @Published private(set) var histories: [ExerciseHistory] = HistoryRepository.shared.getCache()
    @Published private(set) var historySections: [ExerciseHistorySection] = []
    @Published private(set) var historyGrassData: [GrassData] = []
    
    private let historyLimit = 365
    private var canLoadMoreHistoryFromServer = false
    
    private var cancellables: Set<AnyCancellable> = []
    private init() {
        bind()
    }
    
    func update(history: ExerciseHistory) {
        DispatchQueue.main.async {
            withAnimation {
                if let index = self.histories.firstIndex(of: history) {
                    self.histories[index] = history
                } else {
                    self.histories.insert(history, at: 0)
                }
            }
        }
    }
    
    func delete(history: ExerciseHistory) {
        if let index = self.histories.firstIndex(of: history) {
            DispatchQueue.main.async {
                self.histories.remove(at: index)
            }
        }
    }
    
    func updateHistories() {
        Task {
            let histories = try await HistoryRepository.shared.get(lastId: nil, limit: historyLimit)
            canLoadMoreHistoryFromServer = histories.count >= historyLimit
            DispatchQueue.main.async {
                self.histories = histories
            }
            try HistoryRepository.shared.saveCache(histories: histories)
        }
    }
    
    func appendHistories() {
        guard canLoadMoreHistoryFromServer else { return }
        Task {
            let histories = try await HistoryRepository.shared.get(lastId: self.histories.last?.id, limit: historyLimit)
            canLoadMoreHistoryFromServer = histories.count >= historyLimit
            DispatchQueue.main.async {
                self.histories.append(contentsOf: histories)
            }
        }
    }
    
    private func bind() {
        $histories
            .receive(on: DispatchQueue.main)
            .sink { histories in
                self.historySections = self.getHistorySections(histories: histories)
                self.historyGrassData = GrassView.getHistoryGrassData(from: histories)
            }
            .store(in: &cancellables)
    }
    
    private func getHistorySections(histories: [ExerciseHistory]) -> [ExerciseHistorySection] {
        var twoDimensionalArray: [[ExerciseHistory]] = []
        
        // Create a dictionary to group dates by year and month
        var grouped: [String: [ExerciseHistory]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        for history in histories {
            let key = dateFormatter.string(from: history.dateValue ?? Date())
            if grouped[key] == nil {
                grouped[key] = []
            }
            grouped[key]?.append(history)
        }
        
        let sortedKeys = grouped.keys.sorted().reversed()

        for key in sortedKeys {
            if let histories = grouped[key] {
                twoDimensionalArray.append(histories)
            }
        }
        
        return twoDimensionalArray.map({ .init(histories: $0) })
    }
}
