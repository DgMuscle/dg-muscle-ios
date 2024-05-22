//
//  PostHistoryViewModel.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Combine
import Domain

class PostHistoryViewModel: ObservableObject {
    @Published var history: HistoryForm
    private let postHistoryUsecase: PostHistoryUsecase
    private let getExercisesUsecase: GetExercisesUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        history: Domain.History?
    ) {
        postHistoryUsecase = .init(historyRepository: historyRepository)
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
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
    
    func delete(record indexSet: IndexSet) {
        history.records.remove(atOffsets: indexSet)
    }
    
    private func bind() {
        $history
            .receive(on: DispatchQueue.main)
            .sink { [weak self] history in
                let domain: Domain.History = history.domain
                self?.postHistoryUsecase.implement(history: domain)
            }
            .store(in: &cancellables)
    }
}
