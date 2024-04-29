//
//  HistoryFormSetViewModel.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation
import Combine
import SwiftUI

final class HistoryFormSetViewModel: ObservableObject {
    enum ButtonType {
        case up
        case down
    }
    @Published var weight: Double
    @Published var reps: Int
    private let setId: String
    
    var set: ExerciseSetV {
        .init(id: setId, reps: reps, weight: weight)
    }
    
    init(set: ExerciseSetV) {
        weight = set.weight
        reps = set.reps
        setId = set.id
    }
    
    func updateWeight(type: ButtonType) {
        switch type {
        case .up:
            weight += 5
        case .down:
            weight -= 5
        }
    }
    
    func updateReps(type: ButtonType) {
        switch type {
        case .up:
            reps += 1
        case .down:
            reps -= 1
        }
    }
}
