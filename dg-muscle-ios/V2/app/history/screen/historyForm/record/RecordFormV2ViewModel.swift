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
    
    let exerciseRepository: ExerciseRepositoryV2
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Binding<Record>,
         exerciseRepository: ExerciseRepositoryV2) {
        _record = record
        sets = record.wrappedValue.sets
        self.exerciseRepository = exerciseRepository
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
            .sink { [weak self] sets in
                self?.record.sets = sets
                self?.currentVolume = sets.reduce(0, { $0 + $1.volume })
            }
            .store(in: &cancellables)
    }
}
