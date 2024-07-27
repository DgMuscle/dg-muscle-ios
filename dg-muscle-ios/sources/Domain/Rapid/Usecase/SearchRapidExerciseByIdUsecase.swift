//
//  SearchRapidExerciseByIdUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/26/24.
//

import Foundation

public final class SearchRapidExerciseByIdUsecase {
    let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement(id: String) -> RapidExerciseDomain? {
        rapidRepository.get().first(where: { $0.id == id })
    }
}
