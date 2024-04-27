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
    
    let historyRepository: HistoryRepositoryV2
    
    let start = Date().timeIntervalSince1970
    private var timer: Timer?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(history: ExerciseHistory,
         historyRepository: HistoryRepositoryV2) {
        self.history = history
        self.historyRepository = historyRepository
        
        configureDateString()
        configureDuration()
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(configureDuration),
                                             userInfo: nil,
                                             repeats: true)
        
        bind()
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
    
    private func bind() {
        $history
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .filter({ $0.records.isEmpty == false })
            .sink { [weak self] _ in
                self?.post()
            }
            .store(in: &cancellables)
    }
    
    private func post() {
        Task {
            if history.records.isEmpty == false {
                let _ = try await historyRepository.post(data: history)
            }
        }
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
