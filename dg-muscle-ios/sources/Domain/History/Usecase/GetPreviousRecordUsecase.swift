//
//  GetPreviousRecordUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 5/27/24.
//

import Foundation

public final class GetPreviousRecordUsecase {
    private let historyRepository: HistoryRepository
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    public func implement(history: History, record: ExerciseRecord) -> ExerciseRecord? {
        /// filter only histories with dates smaller than received date
        var histories = historyRepository.get()
        histories = histories
            .filter({ $0.id != history.id })
            .filter({ $0.date < history.date })
            .sorted(by: { $0.date > $1.date })
        
        /// find previous record that has same exerciseId with the received record
        let records = histories.flatMap({ $0.records })
        return records.first(where: { $0.exerciseId == record.exerciseId })
    }
}
