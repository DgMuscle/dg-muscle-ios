//
//  HistoryItemViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HistoryItemViewModel: ObservableObject {
    let history: HistoryV
    @Published var day: String = ""
    @Published var parts: [ExerciseV.Part] = []
    @Published var volume: Int = 0
    @Published var time: String?
    @Published var kcal: Double?
    
    private let getDayUsecase: GetDayUsecase
    private let getPartsUsecase: GetPartsUsecase
    private let getKcalUsecase: GetKcalUsecase
    private let getNaturalDurationUsecase: GetNaturalDurationUsecase
    
    private var cancellables = Set<AnyCancellable>()
    init(
        history: HistoryV,
        getDayUsecase: GetDayUsecase,
        getPartsUsecase: GetPartsUsecase,
        getKcalUsecase: GetKcalUsecase,
        getNaturalDurationUsecase: GetNaturalDurationUsecase
    ) {
        self.history = history
        self.getDayUsecase = getDayUsecase
        self.getPartsUsecase = getPartsUsecase
        self.getKcalUsecase = getKcalUsecase
        self.getNaturalDurationUsecase = getNaturalDurationUsecase
        
        bind()
    }
    
    private func bind() {
        day = getDayUsecase.implement(history: history.domain)
        parts = getPartsUsecase.implement(history: history.domain).map({ .init(part: $0) })
        volume = Int(history.volume)
        guard let metaData = history.metaData else { return }
        time = getNaturalDurationUsecase.implement(metadata: metaData.domain)
        kcal = getKcalUsecase.implement(metadata: metaData.domain)
    }
}
