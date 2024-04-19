//
//  MonthlySectionViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import Foundation
import Combine

final class MonthlySectionViewModel: ObservableObject {
    
    @Published var datas: [Data] = []
    
    let exerciseHistorySection: ExerciseHistorySection
    
    init(exerciseHistorySection: ExerciseHistorySection) {
        self.exerciseHistorySection = exerciseHistorySection
        
        configureData()
    }
    
    private func configureData() {
        exerciseHistorySection.histories.forEach({ print($0) })
    }
}

extension MonthlySectionViewModel {
    struct Data {
        var part: Exercise.Part
        var volume: Double
    }
}
