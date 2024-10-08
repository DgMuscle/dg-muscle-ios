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
    @Published var diffWithPreviousRecord: Int?
    @Published var goal: Goal?
    @Published var strengthGoal: Goal?
    @Published var traingMode: Common.TrainingMode?
    
    private let recordId: String
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let subscribeHeatMapColorUsecase: SubscribeHeatMapColorUsecase
    private let getPreviousRecordUsecase: GetPreviousRecordUsecase
    private let getRecordGoalUsecase: GetRecordGoalUsecase
    private let getRecordGoalStrengthUsecase: GetRecordGoalStrengthUsecase
    private let subscribeTrainingModeUsecase: SubscribeTrainingModeUsecase
    private let checkGoalAchievedUsecase: CheckGoalAchievedUsecase
    private let checkStrengthGoalAchievedUsecase: CheckStrengthGoalAchievedUsecase
    private let registerExerciseTimerUsecase: RegisterExerciseTimerUsecase
    private let toggleTrainingModeUsecase: ToggleTrainingModeUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        historyForm: Binding<HistoryForm>,
        recordId: String,
        userRepository: UserRepository,
        historyRepository: HistoryRepository,
        exerciseTimerRepository: ExerciseTimerRepository
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
        getRecordGoalUsecase = .init()
        getRecordGoalStrengthUsecase = .init()
        subscribeTrainingModeUsecase = .init(userRepository: userRepository)
        checkGoalAchievedUsecase = .init()
        checkStrengthGoalAchievedUsecase = .init()
        registerExerciseTimerUsecase = .init(exerciseTimerRepository: exerciseTimerRepository)
        toggleTrainingModeUsecase = .init(userRepository: userRepository)
        
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
    
    func toggleTraningMode() {
        toggleTrainingModeUsecase.implement()
        let type = UINotificationFeedbackGenerator.FeedbackType.success // .error, .error
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    func selectTime(time: Int) {
        
        for i in (0..<10) {
            Common.PushNotificationManager.shared.delete(ids: ["ExerciseTimer\(i)"])
        }
        
        if var date = Calendar.current.date(byAdding: .second, value: time, to: Date()) {
            registerExerciseTimerUsecase.implement(timer: .init(targetDate: date))
            
            for i in (0..<10) {
                Common.PushNotificationManager.shared.register(
                    title: "Ring Ring Ring...",
                    body: "Tap to stop alarm",
                    date: date,
                    id: "ExerciseTimer\(i)",
                    userInfo: [
                        "type": "timer",
                        "targetDate": date
                    ]
                )
                
                if let updatedDate = Calendar.current.date(byAdding: .second, value: 3, to: date) {
                    date = updatedDate
                }
            }
        }
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
            .assign(to: &$color)
        
        $record
            .combineLatest($previousRecord.compactMap({ $0 }))
            .receive(on: DispatchQueue.main)
            .map({ $0.volume - $1.volume })
            .assign(to: &$diffWithPreviousRecord)
        
        $previousRecord
            .compactMap({ $0?.domain })
            .map({ [weak self] in self?.getRecordGoalUsecase.implement(previousRecord: $0) })
            .combineLatest($record)
            .map({ [weak self] (goal, record) -> Goal? in
                guard let self else { return nil }
                if let goal = goal {
                    let achieved = checkGoalAchievedUsecase.implement(goal: goal, record: record.domain)
                    return Goal(weight: goal.weight, reps: goal.reps, achive: achieved)
                } else {
                    return nil
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$goal)
        
        $previousRecord
            .compactMap({ $0?.domain })
            .map({ [weak self] in self?.getRecordGoalStrengthUsecase.implement(previousRecord: $0) })
            .combineLatest($record)
            .map({ [weak self] (goal, record) -> Goal? in
                guard let self else { return nil }
                if let goal = goal {
                    let achieved = checkStrengthGoalAchievedUsecase.implement(goal: goal, record: record.domain)
                    return Goal(weight: goal.weight, reps: goal.reps, achive: achieved)
                } else {
                    return nil
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$strengthGoal)
        
        subscribeTrainingModeUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .map({ Common.TrainingMode(domain: $0) })
            .assign(to: &$traingMode)
    }
}
