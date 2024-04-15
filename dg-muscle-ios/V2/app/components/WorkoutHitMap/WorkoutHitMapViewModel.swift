//
//  WorkoutHitMapViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/15/24.
//

import Foundation
import Combine

final class WorkoutHitMapViewModel: ObservableObject {
    
    @Published var hashMap: [String: [Int]] = [:]
    
    let historyRepository: HistoryRepositoryV2
    let today: Date
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepositoryV2,
         today: Date) {
        self.historyRepository = historyRepository
        self.today = today
        bind()
    }
    
    private func bind() {
        historyRepository
            .historiesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] histories in
                self?.configureHashMap(histories: histories)
            }
            .store(in: &cancellables)
    }
    
    private func configureHashMap(histories: [ExerciseHistory]) {
        /// 오늘을 n번째 주라고 할 때, (n-16 ~ n) 번째 주까지 구한다.
        /// 예) 2024년 16번째 주: hashMap["202416"] = [0, 0, 0, 0, 0, 0, 0]
        ///
        var hashMap: [String: [Int]] = [:]
        
        let calendar = Calendar(identifier: .gregorian)
        var date = today
        // date의 year, weeks 를 구한다.
        
        var count: Int = 17
        
        while count > 0 {
            let year = calendar.component(.year, from: date)
            let weekOfYear = calendar.component(.weekOfYear, from: date)
            var defaultValues: [Int] = [0,0,0,0,0,0,0]
            
            if count == 17 {
                let weekdayNumber = calendar.component(.weekday, from: date)
                /// [1: 일, 2: 월, 3: 화, 4: 수, 5: 목, 6: 금, 7: 토]
                /// [-6, -5, -4, -3, -2, -1, 0]
                defaultValues.removeLast(7 - weekdayNumber)
            }
            
            hashMap["\(year)\(weekOfYear)", default: []].append(contentsOf: defaultValues)
            
            if let newDate = calendar.date(byAdding: .day, value: -7, to: date) {
                date = newDate
            }
            
            count -= 1
        }
        
        print("dg: hashMap is \(hashMap)")
    }
}
