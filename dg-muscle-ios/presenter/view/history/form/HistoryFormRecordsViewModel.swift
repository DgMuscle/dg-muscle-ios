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
    @Published var history: HistoryV
    
    @Published var records: [RecordV] = []
    @Published var currentRecordsCount: Int = 0
    @Published var currentTotalVolume: Double = 0
    @Published var title: String = ""
    
    private let postHistoryUsecase: PostHistoryUsecase
    private var cancellables = Set<AnyCancellable>()
    init(history: HistoryV, postHistoryUsecase: PostHistoryUsecase) {
        self.history = history
        self.records = history.records
        self.postHistoryUsecase = postHistoryUsecase
        configureTitle()
        bind()
    }
    
    func delete(atOffsets: IndexSet) {
        records.remove(atOffsets: atOffsets)
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
        
        $history
            .sink { [weak self] history in
                self?.postHistoryUsecase.implement(data: history.domain)
            }
            .store(in: &cancellables)
    }
    
    private func configureCountVolume(records: [RecordV]) {
        currentRecordsCount = records.count
        currentTotalVolume = records.map({ $0.volume }).reduce(0, +)
    }
    
    private func configureTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        title = dateFormatter.string(from: history.date)
    }
}
