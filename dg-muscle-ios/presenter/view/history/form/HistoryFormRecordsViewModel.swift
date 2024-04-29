//
//  HistoryFormRecordsViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation
import Combine
import SwiftUI

final class HistoryFormRecordsViewModel: ObservableObject {
    @Binding private var history: HistoryV
    
    @Published var records: [RecordV] = []
    @Published var currentRecordsCount: Int = 0
    @Published var currentTotalVolume: Double = 0
    @Published var title: String = ""
    
    var historyDateString: String {
        history.date
    }
    
    private var cancellables = Set<AnyCancellable>()
    init(history: Binding<HistoryV>) {
        _history = history
        self.records = history.wrappedValue.records
        
        configureTitle()
        bind()
    }
    
    func delete(atOffsets: IndexSet) {
        records.remove(atOffsets: atOffsets)
    }
    
    func post(record: RecordV) {
        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records[index] = record
        } else {
            records.append(record)
        }
    }
    
    private func bind() {
        $records
            .receive(on: DispatchQueue.main)
            .sink { [weak self] records in
                self?.history.records = records
                self?.currentRecordsCount = records.count
                self?.currentTotalVolume = records.map({ $0.volume }).reduce(0, +)
            }
            .store(in: &cancellables)
    }
    
    private func configureCountVolume(records: [RecordV]) {
        currentRecordsCount = records.count
        currentTotalVolume = records.map({ $0.volume }).reduce(0, +)
    }
    
    private func configureTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: history.date) else { return }
        dateFormatter.dateFormat = "d MMM y"
        title = dateFormatter.string(from: date)
    }
}
