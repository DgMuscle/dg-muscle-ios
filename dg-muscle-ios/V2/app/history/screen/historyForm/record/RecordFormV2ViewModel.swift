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
    @Binding var record: Record
    @Published var exercise: Exercise? = nil
    
    let exerciseRepository: ExerciseRepositoryV2
    
    init(record: Binding<Record>,
         exerciseRepository: ExerciseRepositoryV2) {
        _record = record
        self.exerciseRepository = exerciseRepository
        configureExercise()
    }
    
    func post(set: ExerciseSet) {
        if let index = record.sets.firstIndex(of: set) {
            record.sets[index] = set
        } else {
            record.sets.append(set)
        }
    }
    
    func delete(at offsets: IndexSet) {
        record.sets.remove(atOffsets: offsets)
    }
    
    private func configureExercise() {
        let exercises = exerciseRepository.exercises
        self.exercise = exercises.first(where: { $0.id == record.exerciseId })
    }
}
