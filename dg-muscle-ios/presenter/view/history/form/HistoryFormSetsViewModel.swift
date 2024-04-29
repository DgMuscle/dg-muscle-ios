//
//  HistoryFormSetsViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation
import Combine
import SwiftUI

final class HistoryFormSetsViewModel: ObservableObject {
    @Binding private var record: RecordV
    
    @Published var sets: [ExerciseSetV] = []
    @Published var currentSetsCount: Int = 0
    @Published var currentRecordVolume: Double = 0
    
    @Published private var previousRecord: RecordV? = nil
    @Published var previousRecordVolume: Double? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(record: Binding<RecordV>) {
        _record = record
        
        self.sets = self.record.sets
        
        bind()
    }
    
    private func bind() {
        $sets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sets in
                self?.currentSetsCount = sets.count
                self?.currentRecordVolume = sets.map({ $0.volume }).reduce(0, +)
                self?.record.sets = sets
            }
            .store(in: &cancellables)
    }
}
