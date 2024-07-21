//
//  RapidSearchByBodyPartViewModel.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine
import Domain
import Common
import SwiftUI

final class RapidSearchByBodyPartViewModel: ObservableObject {
    typealias Thumbnail = RapidExerciseThumbnailPresentation
    
    @Published var datas: [Thumbnail] = []
    @Published var bodyParts: [BodyPart] = RapidBodyPartPresentation.allCases.map({ .init(bodyPart: $0) })
    let color: Color
    
    private let searchRapidExercisesByBodyPartsUsecase: SearchRapidExercisesByBodyPartsUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    
    init(
        rapidRepository: RapidRepository,
        userRepository: UserRepository
    ) {
        searchRapidExercisesByBodyPartsUsecase = .init(rapidRepository: rapidRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        
        let commonColor: Common.HeatMapColor = .init(domain: getHeatMapColorUsecase.implement())
        color = commonColor.color
        
        bind()
    }
    
    func tapPart(part: BodyPart) {
        if let index = bodyParts.firstIndex(of: part) {
            bodyParts[index].toggle()
        }
    }
    
    private func bind() {
        $bodyParts
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
