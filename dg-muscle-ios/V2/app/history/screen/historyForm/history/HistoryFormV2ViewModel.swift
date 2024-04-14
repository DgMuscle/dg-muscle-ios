//
//  HistoryFormV2ViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine
import SwiftUI

final class HistoryFormV2ViewModel: ObservableObject {
    @Published var history: ExerciseHistory
    @Published var dateString: String = ""
    @Published var duration: String = ""
    @Binding var paths: NavigationPath
    
    let historyRepository: HistoryRepositoryV2
    
    private let start = Date().timeIntervalSince1970
    private var timer: Timer?
    
    init(history: ExerciseHistory,
         paths: Binding<NavigationPath>,
         historyRepository: HistoryRepositoryV2) {
        self.history = history
        self._paths = paths
        self.historyRepository = historyRepository
        
        configureDateString()
        configureDuration()
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(configureDuration),
                                             userInfo: nil,
                                             repeats: true)
    }
    
    func post() {
        Task {
            if history.records.isEmpty == false {
                let _ = try await historyRepository.post(data: history)
            }
            paths.removeLast()
        }
    }
    
    func onDelete(indexSet: IndexSet) {
        history.records.remove(atOffsets: indexSet)
    }
    
    private func configureDateString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: history.date) else { return }
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateString = dateFormatter.string(from: date)
    }
    
    @objc private func configureDuration() {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        
        let now = Date().timeIntervalSince1970
        let diff = now - start
        
        if let string = formatter.string(from: TimeInterval(diff)) {
            duration = string
        }
    }
}
