//
//  FriendHistoryListItemViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation
import Combine

final class FriendHistoryListItemViewModel: ObservableObject {
    let history: HistoryV
    let exercises: [ExerciseV]
    @Published var day: String = ""
    @Published var parts: [ExerciseV.Part] = []
    @Published var volume: Int = 0
    @Published var time: String?
    @Published var kcal: Double?
    
    init(history: HistoryV,
         exercises: [ExerciseV]) {
        self.history = history
        self.exercises = exercises
    }
}
