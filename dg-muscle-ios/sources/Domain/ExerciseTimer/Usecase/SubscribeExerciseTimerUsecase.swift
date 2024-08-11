//
//  SubscribeExerciseTimerUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Combine

public final class SubscribeExerciseTimerUsecase {
    private let exerciseTimerRepository: ExerciseTimerRepository
    @Published var timer: ExerciseTimerDomain?
    
    public init(exerciseTimerRepository: ExerciseTimerRepository) {
        self.exerciseTimerRepository = exerciseTimerRepository
        startTimer()
        bind()
    }
    
    public func implement() -> AnyPublisher<ExerciseTimerDomain?, Never> {
        $timer.eraseToAnyPublisher()
    }
    
    private func startTimer() {
        // Timer.scheduledTimer는 지정된 간격으로 타이머를 설정합니다.
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    // 1초마다 호출할 함수
    @objc private func timerDidFire() {
        if let timer {
            if timer.targetDate < Date() {
                self.timer = nil
            } else {
                self.timer = timer
            }
        }
    }
    
    private func bind() {
        exerciseTimerRepository
            .timer
            .assign(to: &$timer)
    }
}
