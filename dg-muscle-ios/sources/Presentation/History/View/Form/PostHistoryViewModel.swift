//
//  PostHistoryViewModel.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Combine
import Domain
import SwiftUI

class PostHistoryViewModel: ObservableObject {
    @Published var history: HistoryForm
    
    private let postHistoryUsecase: PostHistoryUsecase
    private let getExercisesUsecase: GetExercisesUsecase
    private let deleteHistoryUsecase: DeleteHistoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        history: Domain.History?
    ) {
        postHistoryUsecase = .init(historyRepository: historyRepository)
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        deleteHistoryUsecase = .init(historyRepository: historyRepository)
        var historyForm: HistoryForm
        if let history {
            historyForm = .init(domain: history)
        } else {
            historyForm = .init()
        }
        
        let exercises = getExercisesUsecase.implement()
        
        for (index, record) in historyForm.records.enumerated() {
            if let exercise = exercises.first(where: { $0.id == record.exerciseId }) {
                historyForm.records[index].exerciseName = exercise.name
            }
        }
         
        
        self.history = historyForm
        
        bind()
    }
    
    func select(exercise: Exercise) -> (String) {
        let selectedRecordId: String
        
        if let record = history.records.first(where: { $0.exerciseId == exercise.id }) {
            selectedRecordId = record.id
        } else {
            let newRecord: ExerciseRecord = .init(exerciseId: exercise.id, exerciseName: exercise.name)
            history.records.append(newRecord)
            selectedRecordId = newRecord.id
        }
        
        return selectedRecordId
    }
    
    func delete(record indexSet: IndexSet) {
        history.records.remove(atOffsets: indexSet)
    }
    
    private func bind() {
        $history
            .receive(on: DispatchQueue.main)
            .sink { [weak self] history in
                let domain: Domain.History = history.domain
                
                if history.records.isEmpty {
                    self?.deleteHistoryUsecase.implement(history: domain)
                } else {
                    self?.postHistoryUsecase.implement(history: domain)
                }
            }
            .store(in: &cancellables)
    }
}
