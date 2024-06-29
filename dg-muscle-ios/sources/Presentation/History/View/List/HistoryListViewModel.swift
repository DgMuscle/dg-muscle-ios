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
    @Published var historiesGroupedByMonth: [Common.HistorySection] = []
    @Published var color: Color = .green
    @Published var hasExercise: Bool = true
    
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
            .sink {
                [weak self] grouped,
                exercises,
                color in
                
                self?.historiesGroupedByMonth = HistorySection.configureData(
                    grouped: grouped,
                    exercises: exercises,
                    color: color
                )
            }
            .store(in: &cancellables)
        
        subscribeHeatMapUsecase
            .implement()
            .map({ $0.map({ HeatMap(domain: $0) }) })
            .receive(on: DispatchQueue.main)
            .assign(to: &$heatMap)
        
        subscribeHeatMapColorUsecase
            .implement()
            .compactMap({ $0 })
            .map({ Common.HeatMapColor(domain: $0) })
            .map({ $0.color })
            .receive(on: DispatchQueue.main)
            .assign(to: &$color)
        
        subscribeExercisesUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] exercises in
                self?.hasExercise = !exercises.isEmpty
            }
            .store(in: &cancellables)
    }
}

