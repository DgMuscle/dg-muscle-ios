//
//  MonthlySectionViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import Foundation
import Combine

final class MonthlySectionViewModel: ObservableObject {
    
    let exerciseHistorySection: ExerciseHistorySection
    
    init(exerciseHistorySection: ExerciseHistorySection) {
        self.exerciseHistorySection = exerciseHistorySection
    }
}
