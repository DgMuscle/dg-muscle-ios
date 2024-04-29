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
    
    func implement(record: RecordDomain, date: Date) -> RecordDomain? {
        let histories = historyRepository.histories
        var result: RecordDomain?
        
        var stop = false
        
        for history in histories {
            if stop { break }
            guard history.date < date else { continue }
            for previousRecord in history.records {
                if previousRecord.exerciseId == record.exerciseId {
                    result = previousRecord
                    stop = true
                    break
                }
            }
        }
        
        return result
    }
}
