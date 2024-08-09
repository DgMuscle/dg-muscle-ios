//
//  WeightAssembly.swift
//  App
//
//  Created by Donggyu Shin on 8/7/24.
//

import Swinject
import Weight
import Domain

public struct WeightAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(WeightListView.self) { resolver in
            let weightRepository = resolver.resolve(WeightRepository.self)!
            return WeightListView(weightRepository: weightRepository)
        }
        
        container.register(WeightAddView.self) { resolver in
            let weightRepository = resolver.resolve(WeightRepository.self)!
            return WeightAddView(weightRepository: weightRepository)
        }
    }
}
