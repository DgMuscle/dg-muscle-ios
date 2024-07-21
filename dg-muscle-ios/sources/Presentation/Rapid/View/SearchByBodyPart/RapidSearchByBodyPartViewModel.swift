//
//  RapidSearchByBodyPartViewModel.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine
import Domain

final class RapidSearchByBodyPartViewModel: ObservableObject {
    typealias Thumbnail = RapidExerciseThumbnailPresentation
    
    @Published var datas: [Thumbnail] = []
    @Published var selectedBodyParts: [BodyPart] = RapidBodyPartPresentation.allCases.map({ .init(bodyPart: $0) })
    
    private let searchRapidExercisesByBodyPartsUsecase: SearchRapidExercisesByBodyPartsUsecase
    
    init(rapidRepository: RapidRepository) {
        searchRapidExercisesByBodyPartsUsecase = .init(rapidRepository: rapidRepository)
        
        bind()
    }
    
    func tapPart(part: BodyPart) {
        if let index = selectedBodyParts.firstIndex(of: part) {
            selectedBodyParts[index].toggle()
        }
    }
    
    private func bind() {
        $selectedBodyParts
            .compactMap({ (parts) -> [RapidBodyPartPresentation] in
                parts.compactMap({ $0.bodyPart })
            })
            .compactMap({ (parts) -> [RapidBodyPartDomain] in
                parts.compactMap({ $0.domain })
            })
            .compactMap({ [weak self] parts in
                self?.searchRapidExercisesByBodyPartsUsecase.implement(parts: parts)
            })
            .compactMap({ (exercises) -> [Thumbnail] in
                exercises.compactMap({ .init(domain: $0) })
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$datas)
    }
}
