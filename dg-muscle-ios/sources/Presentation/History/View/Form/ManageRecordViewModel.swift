//
//  ManageRecordViewModel.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import Foundation
import Combine
import SwiftUI
import Domain
import Common

final class ManageRecordViewModel: ObservableObject {
    @Binding var historyForm: HistoryForm
    @Published var record: ExerciseRecord
    @Published var color: Color
    @Published var currentVolume: Int
    @Published var previousRecord: ExerciseRecord?
    
    private let recordId: String
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let subscribeHeatMapColorUsecase: SubscribeHeatMapColorUsecase
    private let getPreviousRecordUsecase: GetPreviousRecordUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyForm: Binding<HistoryForm>,
        recordId: String,
        userRepository: UserRepository,
        historyRepository: HistoryRepository
    ) {
        self._historyForm = historyForm
        self.recordId = recordId
        
        let record: ExerciseRecord = historyForm
            .wrappedValue
            .records
            .first(where: { $0.id == recordId }) ??
            .init(id: recordId)
        
        self.record = record
        
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        subscribeHeatMapColorUsecase = .init(userRepository: userRepository)
        getPreviousRecordUsecase = .init(historyRepository: historyRepository)
        
        let color: Common.HeatMapColor = .init(domain: getHeatMapColorUsecase.implement())
        self.color = color.color
        
        currentVolume = record.volume
        if let previousRecord = getPreviousRecordUsecase.implement(
            history: self.historyForm.domain,
            record: self.record.domain
        ) {
            self.previousRecord = .init(domain: previousRecord)
        }
        
        bind()
    }
    
    func post(set: ExerciseSet) {
        if let index = record.sets.firstIndex(where: { $0.id == set.id }) {
            record.sets[index] = set
        } else {
            record.sets.append(set)
        }
    }
    
    func delete(atOffsets: IndexSet) {
        record.sets.remove(atOffsets: atOffsets)
    }
    
    private func bind() {
        $record
            .receive(on: DispatchQueue.main)
            .sink { [weak self] record in
                if let index = self?.historyForm.records.firstIndex(where: { $0.id == record.id }) {
                    self?.historyForm.records[index] = record
                }
                
                self?.currentVolume = record.volume
            }
            .store(in: &cancellables)
        
        subscribeHeatMapColorUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .map({ Common.HeatMapColor(domain: $0) })
            .map({ $0.color })
            .assign(to: \.color, on: self)
            .store(in: &cancellables)
    }
}
