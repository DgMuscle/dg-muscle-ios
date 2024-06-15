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
    
    private let getExercisesUsecase: GetExercisesUsecase
    private let groupExercisesByPartUsecase: GroupExercisesByPartUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(exerciseRepository: ExerciseRepository) {
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        groupExercisesByPartUsecase = .init()
        
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
    }
}
