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
            .compactMap({ [weak self] parts in self?.configureDatas(parts: parts) })
            .receive(on: DispatchQueue.main)
            .assign(to: &$datas)
    }
    
    private func configureDatas(parts: [BodyPart]) -> [Thumbnail] {
        var result: [Thumbnail] = []
        let parts = parts.filter({ $0.selected })
        let rapidBodyPartsDomain: [RapidBodyPartDomain] = parts.compactMap({ $0.bodyPart?.domain })
        let exercieses = searchRapidExercisesByBodyPartsUsecase.implement(parts: rapidBodyPartsDomain)
        result = exercieses.map({ .init(domain: $0) })
        
        return result
    }
}
