//
//  ExerciseSectionsViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class ExerciseSectionsViewModel: ObservableObject {
    @Published var sections: [ExerciseSectionV] = []
    
    private let subscribeGroupedExercisesUsecase: SubscribeGroupedExercisesUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(subscribeGroupedExercisesUsecase: SubscribeGroupedExercisesUsecase) {
        self.subscribeGroupedExercisesUsecase = subscribeGroupedExercisesUsecase
        bind()
    }
    
    private func configureSections(grouped: [ExerciseDomain.Part: [ExerciseDomain]]) {
        var sections: [ExerciseSectionV] = []
        
        for (key, value) in grouped {
            let part: ExerciseV.Part = ExerciseV.convertPart(part: key)
            let exercises: [ExerciseV] = value.map({ .init(from: $0) })
            sections.append(.init(part: part, exercises: exercises))
        }
        
        sections.sort(by: { $0.part.rawValue < $1.part.rawValue })
        
        self.sections = sections
    }
    
    private func bind() {
        subscribeGroupedExercisesUsecase.implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] grouped in
                self?.configureSections(grouped: grouped)
            }
            .store(in: &cancellables)
    }
}
