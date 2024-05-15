//
//  HistoryListViewModel.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain
import HeatMap

final class HistoryListViewModel: ObservableObject {
    @Published var heatMap: [HeatMap] = []
    @Published var historiesGroupedByMonth: [HistorySection] = []
    
    let subscribeHeatMapUsecase: SubscribeHeatMapUsecase
    let subscribeExercisesUsecase: SubscribeExercisesUsecase
    let subscribeHistoriesGroupedByMonthUsecase: SubscribeHistoriesGroupedByMonthUsecase
    
    private var cancellables = Set<AnyCancellable>()
    init(today: Date,
        historyRepository: any HistoryRepository,
         exerciseRepository: any ExerciseRepository,
         heatMapRepository: any HeatMapRepository
         ) {
        subscribeHeatMapUsecase = .init(today: today, historyRepository: historyRepository, heatMapRepository: heatMapRepository)
        subscribeExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        subscribeHistoriesGroupedByMonthUsecase = .init(historyRepository: historyRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeHistoriesGroupedByMonthUsecase
            .implement()
            .combineLatest(subscribeExercisesUsecase.implement())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] grouped, exercises in
                self?.configureData(grouped: grouped, exercises: exercises)
            }
            .store(in: &cancellables)
        
        subscribeHeatMapUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] heatMap in
                self?.heatMap = heatMap.map({ .init(domain: $0) })
            }
            .store(in: &cancellables)
    }
    
    private func configureData(grouped: [String: [Domain.History]], exercises: [Domain.Exercise]) {
        var data: [HistorySection] = []
        
        let dateFormatter = DateFormatter()
        
        for (month, histories) in grouped {
            let historyList: [History] = histories.map({ convert(history: $0, exercises: exercises) })
            dateFormatter.dateFormat = "yyyyMM"
            let date = dateFormatter.date(from: month) ?? Date()
            dateFormatter.dateFormat = "MMM y"
            
            data.append(.init(id: UUID().uuidString,
                              yearMonth: dateFormatter.string(from: date),
                              histories: historyList))
        }
        
        data.sort(by: { $0.yearMonth > $1.yearMonth })
        
        self.historiesGroupedByMonth = data
    }
    
    private func convert(history: Domain.History, exercises: [Domain.Exercise]) -> History {
        
        var parts = Set<Domain.Exercise.Part>()
        let exerciseIdList: [String] = history.records.map({ $0.exerciseId })
        
        
        for id in exerciseIdList {
            if let exercise = exercises.first(where: { $0.id == id }) {
                exercise.parts.forEach({ parts.insert($0) })
            }
        }
        
        return .init(id: history.id,
                     date: history.date,
                     parts: parts.map({ convert(part: $0) }).sorted(),
                     volume: history.volume,
                     color: .green,
                     time: nil,
                     kcal: nil)
    }
    
    private func convert(part: Domain.Exercise.Part) -> String {
        switch part {
        case .arm:
            return "Arm"
        case .back:
            return "Back"
        case .chest:
            return "Chest"
        case .core:
            return "Core"
        case .leg:
            return "Leg"
        case .shoulder:
            return "Shoulder"
        }
    }
}

