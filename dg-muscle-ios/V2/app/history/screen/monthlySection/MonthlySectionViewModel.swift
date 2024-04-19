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
    let exerciseRepository: ExerciseRepositoryV2
    
    init(exerciseHistorySection: ExerciseHistorySection,
         exerciseRepository: ExerciseRepositoryV2) {
        self.exerciseHistorySection = exerciseHistorySection
        self.exerciseRepository = exerciseRepository
        configureData()
    }
    
    private func configureData() {
        var hashMap: [Exercise.Part: Double] = [:]
        
        for history in exerciseHistorySection.histories.map({ $0.exercise }) {
            for record in history.records {
                if let exercise = exerciseRepository.get(exerciseId: record.exerciseId) {
                    for part in exercise.parts {
                        hashMap[part, default: 0] += record.volume
                    }
                }
            }
        }
        
        var datas: [Data] = hashMap.map({ .init(part: $0.key, volume: $0.value) })
        datas.sort(by: { $0.part.rawValue < $1.part.rawValue })
        DispatchQueue.main.async { [weak self] in
            self?.datas = datas
        }
        
        for data in datas {
            print(data)
        }
    }
}

extension MonthlySectionViewModel {
    struct Data {
        var part: Exercise.Part
        var volume: Double
    }
}
