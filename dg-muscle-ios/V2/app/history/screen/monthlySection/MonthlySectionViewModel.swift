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
    // The most common exercise I've done
    @Published var mostExercise: Exercise?
    @Published var mostPart: Exercise.Part?
    @Published var mostVolume: Double = 0
    
    @Published var leastExercise: Exercise?
    @Published var leastPart: Exercise.Part?
    @Published var leastVolume: Double = 0
    
    @Published var maxExerciseVolume: Double = 0
    
    let exerciseHistorySection: ExerciseHistorySection
    let exerciseRepository: ExerciseRepositoryV2
    
    init(exerciseHistorySection: ExerciseHistorySection,
         exerciseRepository: ExerciseRepositoryV2) {
        self.exerciseHistorySection = exerciseHistorySection
        self.exerciseRepository = exerciseRepository
        configureData()
        configureVolume()
        configureExercise()
    }
    
    private func configureExercise() {
        var hashMap: [Exercise: Double] = [:]
        
        for history in exerciseHistorySection.histories.map({ $0.exercise }) {
            for record in history.records {
                if let exercise = exerciseRepository.get(exerciseId: record.exerciseId) {
                    hashMap[exercise, default: 0] += record.volume
                }
            }
        }
        
        self.mostExercise = hashMap.max(by: { $0.value < $1.value })?.key
        self.leastExercise = hashMap.min(by: { $0.value < $1.value })?.key
        
        if let mostExercise {
            self.maxExerciseVolume = hashMap[mostExercise, default: 0]
        }
    }
    
    private func configureVolume() {
        var maxVolume: Double = 0
        var minVolme: Double = 0
        
        for history in exerciseHistorySection.histories.map({ $0.exercise }) {
            if minVolme == 0 {
                minVolme = history.volume
            }
            maxVolume = max(maxVolume, history.volume)
            minVolme = min(minVolme, history.volume)
        }
        
        self.mostVolume = maxVolume
        self.leastVolume = minVolme
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
        
        self.datas = datas
        self.mostPart = hashMap.max(by: { $0.value < $1.value })?.key
        self.leastPart = hashMap.min(by: { $0.value < $1.value })?.key
    }
}

extension MonthlySectionViewModel {
    struct Data: Hashable {
        var part: Exercise.Part
        var volume: Double
    }
}
