//
//  HistoryListViewModel.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain
import HistoryHeatMap
import SwiftUI
import Common

final class HistoryListViewModel: ObservableObject {
    @Published var heatMap: [HistoryHeatMap.HeatMap] = []
    @Published var historiesGroupedByMonth: [HistorySection] = []
    @Published var color: Color = .green
    
    let subscribeHeatMapUsecase: SubscribeHeatMapUsecase
    let subscribeExercisesUsecase: SubscribeExercisesUsecase
    let subscribeHistoriesGroupedByMonthUsecase: SubscribeHistoriesGroupedByMonthUsecase
    let subscribeHeatMapColorUsecase: SubscribeHeatMapColorUsecase
    
    private var cancellables = Set<AnyCancellable>()
    init(today: Date,
         historyRepository: any HistoryRepository,
         exerciseRepository: any ExerciseRepository,
         heatMapRepository: any HeatMapRepository,
         userRepository: any UserRepository
    ) {
        subscribeHeatMapUsecase = .init(today: today, historyRepository: historyRepository, heatMapRepository: heatMapRepository)
        subscribeExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        subscribeHistoriesGroupedByMonthUsecase = .init(historyRepository: historyRepository)
        subscribeHeatMapColorUsecase = .init(userRepository: userRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeHistoriesGroupedByMonthUsecase
            .implement()
            .combineLatest(
                subscribeExercisesUsecase.implement(),
                $color
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] grouped, exercises, color in
                self?.configureData(grouped: grouped, exercises: exercises, color: color)
            }
            .store(in: &cancellables)
        
        subscribeHeatMapUsecase
            .implement()
            .map({ $0.map({ HeatMap(domain: $0) }) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.heatMap, on: self)
            .store(in: &cancellables)
        
        subscribeHeatMapColorUsecase
            .implement()
            .compactMap({ $0 })
            .map({ Common.HeatMapColor(domain: $0) })
            .map({ $0.color })
            .receive(on: DispatchQueue.main)
            .assign(to: \.color, on: self)
            .store(in: &cancellables)
    }
    
    private func configureData(grouped: [String: [Domain.History]], exercises: [Domain.Exercise], color: Color) {
        var data: [HistorySection] = []
        
        let dateFormatter = DateFormatter()
        
        for (month, histories) in grouped {
            let historyList: [History] = histories.map({ convert(history: $0, exercises: exercises, color: color) })
            dateFormatter.dateFormat = "yyyyMM"
            let date = dateFormatter.date(from: month) ?? Date()
            dateFormatter.dateFormat = "MMM y"
            
            data.append(
                .init(
                    id: UUID().uuidString,
                    yearMonth: dateFormatter.string(from: date),
                    histories: historyList,
                    yyyyMM: month
                )
            )
        }
        
        data.sort(by: { $0.yyyyMM > $1.yyyyMM })
        
        self.historiesGroupedByMonth = data
    }
    
    private func convert(history: Domain.History, exercises: [Domain.Exercise], color: Color) -> History {
        
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
                     color: color,
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

