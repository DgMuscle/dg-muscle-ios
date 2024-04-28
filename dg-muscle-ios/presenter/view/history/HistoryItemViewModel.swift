//
//  HistoryItemViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HistoryItemViewModel: ObservableObject {
    @Published var history: HistoryV
    @Published var day: String = ""
    @Published var parts: [ExerciseV.Part] = []
    @Published var time: String?
    @Published var kcal: Double?
    
    let getDayUsecase: GetDayUsecase
    let getPartsUsecase: GetPartsUsecase
    let getKcalUsecase: GetKcalUsecase?
    let getNaturalDurationUsecase: GetNaturalDurationUsecase?
    
    init(
        history: HistoryV,
        getDayUsecase: GetDayUsecase,
        getPartsUsecase: GetPartsUsecase,
        getKcalUsecase: GetKcalUsecase?,
        getNaturalDurationUsecase: GetNaturalDurationUsecase?
    ) {
        self.history = history
        self.getDayUsecase = getDayUsecase
        self.getPartsUsecase = getPartsUsecase
        self.getKcalUsecase = getKcalUsecase
        self.getNaturalDurationUsecase = getNaturalDurationUsecase
        
        bind()
    }
    
    private func bind() {
        day = getDayUsecase.implement()
        parts = getPartsUsecase.implement().compactMap({ .init(rawValue: $0.rawValue) })
        time = getNaturalDurationUsecase?.implement()
        kcal = getKcalUsecase?.implement()
    }
}
