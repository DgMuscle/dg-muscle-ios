//
//  RecordFormV2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine
import SwiftUI

final class RecordFormV2ViewModel: ObservableObject {
    @Binding private var record: Record
    
    @Published var sets: [ExerciseSet]
    @Published var currentVolume: Double = 0
    @Published var exercise: Exercise? = nil
    
    @Published var previousRecord: Record?
    @Published var previousDate: Date?
    
    let exerciseRepository: ExerciseRepositoryV2
    let historyRepository: HistoryRepositoryV2
    let date: Date
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Binding<Record>,
         exerciseRepository: ExerciseRepositoryV2,
         historyRepository: HistoryRepositoryV2,
         date: Date) {
        _record = record
        sets = record.wrappedValue.sets
        self.exerciseRepository = exerciseRepository
        self.historyRepository = historyRepository
        self.date = date
        
        configureExercise()
        bind()
    }
    
    func post(set: ExerciseSet) {
        if let index = sets.firstIndex(of: set) {
            sets[index] = set
        } else {
            sets.append(set)
        }
    }
    
    func delete(at offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }
    
    private func configureExercise() {
        let exercises = exerciseRepository.exercises
        self.exercise = exercises.first(where: { $0.id == record.exerciseId })
    }
    
    private func bind() {
        $sets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sets in
                self?.record.sets = sets
                self?.currentVolume = sets.reduce(0, { $0 + $1.volume })
            }
            .store(in: &cancellables)
        
        $exercise
            .compactMap({ $0 })
            .sink { [weak self] exercise in
                self?.configurePreviousDate(exercise: exercise)
            }
            .store(in: &cancellables)
    }
    
    private func configurePreviousDate(exercise: Exercise) {
        let histories = historyRepository.histories.sorted(by: { $0.date > $1.date })
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        
        var escape = false
        
        for history in histories {
            if escape { break }
            if history.date == dateString { continue }
            
            for record in history.records {
                if record.exerciseId == self.record.exerciseId {
                    let date = dateFormatter.date(from: history.date)
                    
                    self.previousRecord = record
                    self.previousDate = date
                    escape = true
                    break
                }
            }
        }
    }
}
