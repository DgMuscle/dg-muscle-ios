//
//  HistoryStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Combine
import Foundation

final class HistoryStore: ObservableObject {
    static let shared = HistoryStore()
    
    @Published private(set) var histories: [ExerciseHistory] = []
    @Published private(set) var historySections: [ExerciseHistorySection] = []
    
    private var updateHistoriesTask: Task<(), Error>?
    private var appendHistoriesTask: Task<(), Error>?
    
    private(set) var cancellables: Set<AnyCancellable> = []
    private init() {
        bind()
    }
    
    func updateHistories() {
        guard updateHistoriesTask == nil else { return }
        updateHistoriesTask = Task {
            let histories = try await HistoryRepository.shared.get(lastId: nil)
            DispatchQueue.main.async {
                self.histories = histories
            }
            updateHistoriesTask = nil
        }
    }
    
    func appendHistories() {
        guard appendHistoriesTask == nil else { return }
        appendHistoriesTask = Task {
            let histories = try await HistoryRepository.shared.get(lastId: self.histories.last?.id)
            DispatchQueue.main.async {
                self.histories.append(contentsOf: histories)
            }
            appendHistoriesTask = nil
        }
    }
    
    private func bind() {
        $histories
            .receive(on: DispatchQueue.main)
            .sink { histories in
                let sections = self.getHistorySections(histories: histories)
                self.historySections = sections
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
