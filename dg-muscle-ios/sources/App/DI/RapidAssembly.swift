//
//  RapidAssembly.swift
//  App
//
//  Created by 신동규 on 7/21/24.
//

import Swinject
import Domain
import Presentation
import Rapid

public struct RapidAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        
        container.register(RapidSearchTypeListView.self) { resolver in
            return RapidSearchTypeListView()
        }
        
        container.register(RapidSearchByBodyPartView.self) { resolver in
            let rapidRepository = resolver.resolve(RapidRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            return RapidSearchByBodyPartView(
                rapidRepository: rapidRepository,
                userRepository: userRepository
            )
        }
        
        container.register(RapidSearchByNameView.self) { resolver in
            let rapidRepository = resolver.resolve(RapidRepository.self)!
            return RapidSearchByNameView(rapidRepository: rapidRepository)
        }
        
        container.register(RapidExerciseDetailView.self) { (resolver, exercise: RapidExerciseDomain) in
            
            let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
            
            return RapidExerciseDetailView(exercise: exercise,
                                           exerciseRepository: exerciseRepository)
        }
    }
}
