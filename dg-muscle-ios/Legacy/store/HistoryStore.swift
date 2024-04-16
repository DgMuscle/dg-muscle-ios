//
//  HistoryStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Combine
import Foundation
import SwiftUI
import WidgetKit

final class HistoryStore: ObservableObject {
    static let shared = HistoryStore()
    
    @Published private(set) var histories: [ExerciseHistory] = []
    @Published private(set) var historySections: [ExerciseHistorySection] = []
    @Published private(set) var historyGrassData: [GrassData] = []
    @Published private(set) var metadatas: [WorkoutMetaData] = []
    
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
//                try? HistoryRepository.shared.saveCache(histories: self.histories)
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
//            let histories = try await HistoryRepository.shared.get(lastId: nil, limit: historyLimit)
//            canLoadMoreHistoryFromServer = histories.count >= historyLimit
//            DispatchQueue.main.async {
//                self.histories = histories
//            }
//            try HistoryRepository.shared.saveCache(histories: histories)
//            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func appendHistories() {
//        guard canLoadMoreHistoryFromServer else { return }
//        Task {
//            let histories = try await HistoryRepository.shared.get(lastId: self.histories.last?.id, limit: historyLimit)
//            canLoadMoreHistoryFromServer = histories.count >= historyLimit
//            DispatchQueue.main.async {
//                self.histories.append(contentsOf: histories)
//            }
//        }
    }
    
    func set(metadatas: [WorkoutMetaData]) {
        self.metadatas = metadatas
    }
    
    private func bind() {
        $histories
            .combineLatest($metadatas)
            .receive(on: DispatchQueue.main)
            .sink { histories, metadatas in
                self.historySections = self.getHistorySections(histories: histories, metadatas: metadatas)
                self.historyGrassData = GrassView.getData(from: histories)
            }
            .store(in: &cancellables)
    }
    
    private func getHistorySections(histories: [ExerciseHistory], metadatas: [WorkoutMetaData]) -> [ExerciseHistorySection] {
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
        
        return twoDimensionalArray.map({ ExerciseHistorySection(histories: $0.map({ exercise in
            let metadata = metadatas.first(where: { exercise.date == $0.startDateString })
            return .init(exercise: exercise, metadata: metadata) })
        )})
    }
}
