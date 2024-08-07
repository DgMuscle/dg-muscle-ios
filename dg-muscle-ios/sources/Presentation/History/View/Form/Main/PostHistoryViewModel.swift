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
import Common

class PostHistoryViewModel: ObservableObject {
    @Published var history: HistoryForm
    @Published var color: Common.HeatMapColor
    
    private let postHistoryUsecase: PostHistoryUsecase
    private let getExercisesUsecase: GetExercisesUsecase
    private let deleteHistoryUsecase: DeleteHistoryUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let subscribeHeatMapColorUsecase: SubscribeHeatMapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        history: Domain.History?,
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository
    ) {
        postHistoryUsecase = .init(historyRepository: historyRepository)
        getExercisesUsecase = .init(exerciseRepository: exerciseRepository)
        deleteHistoryUsecase = .init(historyRepository: historyRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        subscribeHeatMapColorUsecase = .init(userRepository: userRepository)
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
        self.color = .init(domain: getHeatMapColorUsecase.implement())
        
        bind()
    }
    
    func select(exercise: HistoryExercise) -> (String) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.history.records.remove(atOffsets: indexSet)
        }
    }
    
    func deleteRun(indexSet: IndexSet) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.history.run.remove(atOffsets: indexSet)
        }
    }
    
    func deleteMemo(indexSet: IndexSet) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.history.memo.remove(atOffsets: indexSet)
        }
    }
    
    private func bind() {
        $history
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] history in
                let domain: Domain.History = history.domain
                
                if history.volume == 0 && history.memo.isEmpty && history.run.isEmpty {
                    self?.deleteHistoryUsecase.implement(history: domain)
                } else {
                    self?.postHistoryUsecase.implement(history: domain)
                }
            }
            .store(in: &cancellables)
        
        subscribeHeatMapColorUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .compactMap({ $0 })
            .map({ Common.HeatMapColor(domain: $0) })
            .assign(to: &$color)
    }
}
