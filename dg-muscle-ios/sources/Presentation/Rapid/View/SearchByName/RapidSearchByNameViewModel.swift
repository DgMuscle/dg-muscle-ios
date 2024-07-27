//
//  RapidSearchByNameViewModel.swift
//  Rapid
//
//  Created by 신동규 on 7/25/24.
//

import Foundation
import Combine
import Domain

final class RapidSearchByNameViewModel: ObservableObject {
    typealias Thumbnail = RapidExerciseThumbnailPresentation
    
    @Published var datas: [Thumbnail] = []
    @Published var query: String = ""
    @Published var loading: Bool = false
    
    private let searchRapidExercisesByNameUsecase: SearchRapidExercisesByNameUsecase
    private let subscribeRapidExercisesLoadingUsecase: SubscribeRapidExercisesLoadingUsecase
    
    init(rapidRepository: RapidRepository) {
        searchRapidExercisesByNameUsecase = .init(rapidRepository: rapidRepository)
        subscribeRapidExercisesLoadingUsecase = .init(rapidRepository: rapidRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeRapidExercisesLoadingUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .assign(to: &$loading)
        
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .compactMap({ [weak self] query -> [RapidExerciseDomain]? in
                guard let self else { return nil }
                let result = searchRapidExercisesByNameUsecase.implement(name: query)
                return result
            })
            .map({ rapidExercises -> [Thumbnail] in
                rapidExercises.map({ .init(domain: $0) })
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$datas)
    }
}
