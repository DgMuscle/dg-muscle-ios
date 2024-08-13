//
//  NavigationViewModel.swift
//  Presentation
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Domain
import Combine
import ExerciseTimer
import Common

final class NavigationViewModel: ObservableObject {
    let subscribeExerciseTimerUsecase: SubscribeExerciseTimerUsecase
    let cancelExerciseTimerUsecase: CancelExerciseTimerUsecase
    
    @Published var timer: ExerciseTimerPresentation?
    
    init(exerciseTimerRepository: ExerciseTimerRepository) {
        subscribeExerciseTimerUsecase = .init(exerciseTimerRepository: exerciseTimerRepository)
        cancelExerciseTimerUsecase = .init(exerciseTimerRepository: exerciseTimerRepository)
        
        bind()
    }
    
    func cancelTimer() {
        cancelExerciseTimerUsecase.implement()
        for i in (0..<10) {
            Common.PushNotificationManager.shared.delete(ids: ["ExerciseTimer\(i)"])
        }
    }
    
    private func bind() {
        subscribeExerciseTimerUsecase
            .implement()
            .map({ timer -> ExerciseTimerPresentation? in
                var result: ExerciseTimerPresentation?
                if let timer {
                    result = .init(domain: timer)
                }
                return result
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$timer)
    }
}
