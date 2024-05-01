//
//  GetPreviousRecordUsecase.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation

final class GetPreviousRecordUsecase {
    let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement(record: RecordDomain, date: Date) -> (RecordDomain, Date)? {
        var histories = historyRepository.histories
        let calendar = Calendar.current
        histories = histories
            .filter({ calendar.isDate(date, inSameDayAs: $0.date) })
            .sorted(by: { $0.date > $1.date })
        
        var result: RecordDomain?
        var resultDate: Date?
        
        var stop = false
        
        for history in histories {
            if stop { break }
            guard history.date < date else { continue }
            for previousRecord in history.records {
                if previousRecord.exerciseId == record.exerciseId {
                    result = previousRecord
                    resultDate = history.date
                    stop = true
                    break
                }
            }
        }
        
        if let result, let resultDate {
            return (result, resultDate)
        } else {
            return nil
        }
    }
}
