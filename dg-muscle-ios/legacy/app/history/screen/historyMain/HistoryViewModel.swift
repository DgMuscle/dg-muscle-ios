//
//  HistoryViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation

final class HistoryViewModel: ObservableObject {
    @Published private(set) var historySections: [ExerciseHistorySection] = []
    @Published private(set) var user: DGUser?
    
    private let historyRepository: HistoryRepositoryV2
    private let healthRepository: HealthRepository
    private let userRepository: UserRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepositoryV2,
         healthRepository: HealthRepository,
         userRepository: UserRepositoryV2) {
        self.historyRepository = historyRepository
        self.healthRepository = healthRepository
        self.userRepository = userRepository
        bind()
    }
    
    func delete(history: ExerciseHistory) {
        Task {
            try await historyRepository.delete(data: history)
        }
    }
    
    func findTodayExerciseHistory() -> ExerciseHistory? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let todayDateString = dateFormatter.string(from: Date())
        return historyRepository.histories.first(where: { $0.date == todayDateString })
    }
    
    private func bind() {
        historyRepository.historiesPublisher
            .combineLatest(healthRepository.workoutMetaDatasPublisher)
            .sink { [weak self] histories, metadatas in
                guard let self else { return }
                let historySections: [ExerciseHistorySection] = getHistorySections(histories: histories, metadatas: metadatas)
                
                DispatchQueue.main.async {
                    self.historySections = historySections
                }
            }
            .store(in: &cancellables)
        
        userRepository.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }
                self.user = user
            }
            .store(in: &cancellables)
    }
    
    // O(n)
    private func getHistorySections(histories: [ExerciseHistory], metadatas: [WorkoutMetaData]) -> [ExerciseHistorySection] {
        var twoDimensionalArray: [[ExerciseHistory]] = []
        
        var grouped: [String: [ExerciseHistory]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        for history in histories {
            let key = dateFormatter.string(from: history.dateValue ?? Date())
            if grouped[key] == nil {
                grouped[key] = []
            }
            grouped[key, default: []].append(history)
        }
        
        let sortedKeys = grouped.keys.sorted().reversed()
        
        for key in sortedKeys {
            if let histories = grouped[key] {
                twoDimensionalArray.append(histories)
            }
        }
        
        var metaDataHashMap: [String: WorkoutMetaData] = [:]
        
        for data in metadatas {
            metaDataHashMap[data.startDateString] = data
        }
        
        return twoDimensionalArray.map({ ExerciseHistorySection(histories: $0.map({ exercise in
            let metadata = metaDataHashMap[exercise.date]
            return .init(exercise: exercise, metadata: metadata) })
        )})
    }
}
