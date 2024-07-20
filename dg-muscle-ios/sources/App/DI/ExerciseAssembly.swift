//
//  ExerciseAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Exercise
import Domain
import Presentation
import Common

public struct ExerciseAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(ExerciseListView.self) { resolver in
            let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return ExerciseListView(exerciseRepository: exerciseRepository,
                                    historyRepository: historyRepository, 
                                    userRepository: userRepository) { exercise in
                coordinator?.exercise.addExercise(exercise: exercise)
            }
        }
        
        container.register(PostExerciseView.self) { (resolver, exercise: Domain.Exercise?) in
            let repository = resolver.resolve(ExerciseRepository.self)!
            return PostExerciseView(exercise: exercise, exerciseRepository: repository) {
                URLManager.shared.open(url: "dgmuscle://pop")
            }
        }
    }
}
