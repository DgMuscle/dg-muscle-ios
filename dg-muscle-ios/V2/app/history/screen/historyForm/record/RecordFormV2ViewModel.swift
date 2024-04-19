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
    @Published var duration: String = "..."
    
    let exerciseRepository: ExerciseRepositoryV2
    let historyRepository: HistoryRepositoryV2
    let date: Date
    let startTimeInterval: TimeInterval
    
    private var timer: Timer?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Binding<Record>,
         exerciseRepository: ExerciseRepositoryV2,
         historyRepository: HistoryRepositoryV2,
         date: Date,
         startTimeInterval: TimeInterval) {
        _record = record
        sets = record.wrappedValue.sets
        self.exerciseRepository = exerciseRepository
        self.historyRepository = historyRepository
        self.date = date
        self.startTimeInterval = startTimeInterval
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(configureDuration),
                                             userInfo: nil,
                                             repeats: true)
        
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        
        let histories = historyRepository.histories
            .filter({ $0.date < dateString })
            .sorted(by: { $0.date > $1.date })
        
        var escape = false
        
        for history in histories {
            if escape { break }
            
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
    
    @objc private func configureDuration() {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        
        let now = Date().timeIntervalSince1970
        let diff = now - startTimeInterval
        
        if let string = formatter.string(from: TimeInterval(diff)) {
            duration = string
        }
    }
}
