//
//  SelectExerciseViewModel.swift
//  History
//
//  Created by Donggyu Shin on 5/23/24.
//

import Foundation
import Combine
import Domain

final class SelectExerciseViewModel: ObservableObject {
    @Published var exericeSections: [ExerciseSection]
    @Published var onlyShowsFavoriteExercises: Bool
    
    private let getExercisesUsecase: GetExercisesUsecase
    private let groupExercisesByPartUsecase: GroupExercisesByPartUsecase
    private let updateOnlyShowsFavoriteExercisesUsecase: UpdateOnlyShowsFavoriteExercisesUsecase
    private let subscribeOnlyShowsFavoriteExercisesUsecase: SubscribeOnlyShowsFavoriteExercisesUsecase
    
    init(
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository
    ) {
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        groupExercisesByPartUsecase = .init()
        updateOnlyShowsFavoriteExercisesUsecase = .init(userRepository: userRepository)
        subscribeOnlyShowsFavoriteExercisesUsecase = .init(userRepository: userRepository)
        
        onlyShowsFavoriteExercises = userRepository.get()?.onlyShowsFavoriteExercises ?? false
        
        let grouped = groupExercisesByPartUsecase.implement(
            exercises: getExercisesUsecase.implement()
        )
        
        var exericeSections: [ExerciseSection] = []
        
        for (part, exercises) in grouped {
            let section = ExerciseSection(
                part: .init(
                    domain: part
                ),
                exercises: exercises.map({
                    .init(
                        domain: $0
                    )
                })
            )
            exericeSections.append(section)
        }
        
        exericeSections = exericeSections
            .sorted(by: { $0.part.rawValue < $1.part.rawValue })
        
        self.exericeSections = exericeSections
        
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
    }
}
