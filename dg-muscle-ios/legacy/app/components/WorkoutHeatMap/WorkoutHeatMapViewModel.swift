//
//  WorkoutHeatMapViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/15/24.
//

import Foundation
import Combine

final class WorkoutHeatMapViewModel: ObservableObject {
    
    @Published var datas: [Data] = [] {
        didSet {
            try? historyRepository.post(data: datas)
        }
    }
    
    @Published var heatmapColor: HeatmapColor = .green
    
    let historyRepository: HistoryRepositoryV2
    let today: Date
    let heatmapRepository: HeatmapRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepositoryV2,
         today: Date,
         heatmapRepository: HeatmapRepository) {
        self.historyRepository = historyRepository
        self.today = today
        self.heatmapRepository = heatmapRepository
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
        
        heatmapRepository
            .colorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] color in
                self?.heatmapColor = color
            }
            .store(in: &cancellables)
    }
    
    private func configureHashMap(histories: [ExerciseHistory]) {
        /// 오늘을 n번째 주라고 할 때, (n-16 ~ n) 번째 주까지 구한다.
        /// 예) 2024년 16번째 주: hashMap["202416"] = [0, 0, 0, 0, 0, 0, 0]
        ///
        var hashMap: [String: [Double]] = [:]
        
        let calendar = Calendar(identifier: .gregorian)
        var date = today
        // date의 year, weeks 를 구한다.
        
        var count: Int = 17
        
        while count > 0 {
            let year = calendar.component(.year, from: date)
            let weekOfYear = calendar.component(.weekOfYear, from: date)
            var defaultValues: [Double] = [0,0,0,0,0,0,0]
            
            if count == 17 {
                let weekdayNumber = calendar.component(.weekday, from: date)
                /// [1: 일, 2: 월, 3: 화, 4: 수, 5: 목, 6: 금, 7: 토]
                /// [-6, -5, -4, -3, -2, -1, 0]
                defaultValues.removeLast(7 - weekdayNumber)
            }
            
            var key: String = "\(year)\(weekOfYear)"
            if weekOfYear < 10 {
                key = "\(year)0\(weekOfYear)"
            }
            
            hashMap[key, default: []].append(contentsOf: defaultValues)
            
            if let newDate = calendar.date(byAdding: .day, value: -7, to: date) {
                date = newDate
            }
            
            count -= 1
        }
        
        for history in histories {
            if let date = history.dateValue {
                let year = calendar.component(.year, from: date)
                let weekOfYear = calendar.component(.weekOfYear, from: date)
                let weekdayNumber = calendar.component(.weekday, from: date)
                
                var key: String = "\(year)\(weekOfYear)"
                if weekOfYear < 10 {
                    key = "\(year)0\(weekOfYear)"
                }
                
                hashMap[key]?[weekdayNumber - 1] = history.volume
            }
        }
        
        let datas: [Data] = hashMap
            .map({ .init(week: $0.key, volumes: $0.value.map({ .init(value: $0)}) ) })
            .sorted(by: { $0.week < $1.week })
        
        self.datas = datas
    }
}

extension WorkoutHeatMapViewModel {
    struct Data: Identifiable, Codable {
        var id: String = UUID().uuidString
        var week: String
        var volumes: [Volume]
    }
    
    struct Volume: Identifiable, Codable {
        var id: String = UUID().uuidString
        var value: Double
    }
}
