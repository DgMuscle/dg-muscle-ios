//
//  HistoryViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation

final class HistoryViewModel: ObservableObject {
    @Published private(set) var grassData: [GrassData] = []
    @Published private(set) var historySections: [ExerciseHistorySection] = []
    
    private let historyRepository: HistoryRepositoryV2
    private let healthRepository: HealthRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepositoryV2,
         healthRepository: HealthRepository) {
        self.historyRepository = historyRepository
        self.healthRepository = healthRepository
        bind()
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
    }
    
    private func getHistorySections(histories: [ExerciseHistory], metadatas: [WorkoutMetaData]) -> [ExerciseHistorySection] {
        var twoDimensionalArray: [[ExerciseHistory]] = []
        
        // Create a dictionary to group dates by year and month
        var grouped: [String: [ExerciseHistory]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        // O(n)
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
        
        return twoDimensionalArray.map({ ExerciseHistorySection(histories: $0.map({ exercise in
            let metadata = metadatas.first(where: { exercise.date == $0.startDateString })
            return .init(exercise: exercise, metadata: metadata) })
        )})
    }
}
