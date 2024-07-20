//
//  SelectExerciseViewModel.swift
//  History
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Combine
import Domain
import SwiftUI
import Common

final class SelectExerciseViewModel: ObservableObject {
    @Published var exericeSections: [ExerciseSection] = []
    @Published var onlyShowsFavoriteExercises: Bool
    let color: Color
    
    private let getExercisesUsecase: GetExercisesUsecase
    private let groupExercisesByPartUsecase: GroupExercisesByPartUsecase
    private let updateOnlyShowsFavoriteExercisesUsecase: UpdateOnlyShowsFavoriteExercisesUsecase
    private let subscribeOnlyShowsFavoriteExercisesUsecase: SubscribeOnlyShowsFavoriteExercisesUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let getExercisePopularityUsecase: GetExercisePopularityUsecase
    
    init(
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository,
        historyRepository: HistoryRepository
    ) {
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        groupExercisesByPartUsecase = .init()
        updateOnlyShowsFavoriteExercisesUsecase = .init(userRepository: userRepository)
        subscribeOnlyShowsFavoriteExercisesUsecase = .init(userRepository: userRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        getExercisePopularityUsecase = .init(
            exerciseRepository: exerciseRepository,
            historyRepository: historyRepository
        )
        
        onlyShowsFavoriteExercises = userRepository.get()?.onlyShowsFavoriteExercises ?? false
        
        let heatmapColor: Common.HeatMapColor = .init(domain: getHeatMapColorUsecase.implement())
        self.color = heatmapColor.color
        
        bind()
    }
    
    func updateOnlyShowsFavoriteExercises(value: Bool) {
        updateOnlyShowsFavoriteExercisesUsecase.implement(value: value)
    }
    
    private func bind() {
        subscribeOnlyShowsFavoriteExercisesUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .assign(to: &$onlyShowsFavoriteExercises)
        
        $onlyShowsFavoriteExercises
            .receive(on: DispatchQueue.main)
            .compactMap({ [weak self] (favorite) -> [Exercise.Part: [Exercise]]? in
                guard let self else { return nil }
                let exercises = getExercisesUsecase.implement()
                let grouped = groupExercisesByPartUsecase.implement(exercises: exercises, onlyShowsFavorite: favorite)
                return grouped
            })
            .map({
                $0.map({ part, exercises in ExerciseSection(part: .init(domain: part), exercises: exercises.map({ .init(domain: $0) }))})
            })
            .assign(to: &$exericeSections)
            
    }
}
