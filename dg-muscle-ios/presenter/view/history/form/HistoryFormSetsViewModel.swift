//
//  HistoryFormSetsViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation
import Combine
import SwiftUI

final class HistoryFormSetsViewModel: ObservableObject {
    @Binding private var record: RecordV
    
    @Published var sets: [ExerciseSetV] = []
    @Published var currentSetsCount: Int = 0
    @Published var currentRecordVolume: Double = 0
    
    @Published var previousRecord: RecordV? = nil
    @Published var previousRecordVolume: Double? = nil
    
    @Published var diffWithPrevious: Double?
    
    @Published var exercise: ExerciseV?
    
    private let previousDateString: String
    private let getPreviousRecordUsecase: GetPreviousRecordUsecase
    private let getExerciseUsecase: GetExerciseUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Binding<RecordV>,
         previousDateString: String,
         getPreviousRecordUsecase: GetPreviousRecordUsecase,
         getExerciseUsecase: GetExerciseUsecase) {
        _record = record
        self.previousDateString = previousDateString
        self.getPreviousRecordUsecase = getPreviousRecordUsecase
        self.getExerciseUsecase = getExerciseUsecase
        self.sets = self.record.sets
        if let exerciseDomain = getExerciseUsecase.implement(exerciseId: record.wrappedValue.exerciseId) {
            self.exercise = .init(from: exerciseDomain)
        }
        bind()
        configurePreviousRecord(record: record.wrappedValue)
    }
    
    func post(set: ExerciseSetV) {
        if let index = sets.firstIndex(where: { $0.id == set.id }) {
            sets[index] = set
        } else {
            sets.append(set)
        }
    }
    
    private func bind() {
        $sets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sets in
                self?.currentSetsCount = sets.count
                self?.currentRecordVolume = sets.map({ $0.volume }).reduce(0, +)
                self?.record.sets = sets
            }
            .store(in: &cancellables)
        
        $previousRecord
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .sink { [weak self] record in
                self?.previousRecordVolume = record.volume
            }
            .store(in: &cancellables)
        
        $currentRecordVolume
            .combineLatest($previousRecordVolume.compactMap({ $0 }))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] current, previous in
                self?.diffWithPrevious = current - previous
            }
            .store(in: &cancellables)
    }
    
    private func configurePreviousRecord(record: RecordV) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: previousDateString) else { return }
        guard let previousRecordDomain = getPreviousRecordUsecase.implement(record: record.domain, date: date) else { return }
        previousRecord = .init(from: previousRecordDomain)
    }
}
