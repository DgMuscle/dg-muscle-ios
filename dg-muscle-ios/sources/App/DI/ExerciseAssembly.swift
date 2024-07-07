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
            let repository = resolver.resolve(ExerciseRepository.self)!
            return ExerciseListView(exerciseRepository: repository) { exercise in
                coordinator?.addExercise(exercise: exercise)
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
