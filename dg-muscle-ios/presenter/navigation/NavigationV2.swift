//
//  MainNavigationV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

struct MainNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case setting
        case heatmapColor
        case profile
        case profilePhoto
    }
    
    var id: Int { name.hashValue }
    let name: Name
}

struct HistoryNavigationV2: Identifiable, Hashable, Equatable {
    static func == (lhs: HistoryNavigationV2, rhs: HistoryNavigationV2) -> Bool {
        lhs.id == rhs.id
    }
    
    enum Name: String {
        case historyForm
        case recordForm
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var id: Int { name.hashValue }
    let name: Name
    
    var historyFormParameter: HistoryV? = nil
    
    var recordForForm: Binding<RecordV>? = nil
    var historyDateForForm: String? = nil
    
    init(historyForm history: HistoryV) {
        name = .historyForm
        historyFormParameter = history
    }
    
    init(recordForForm: Binding<RecordV>, historyDateForForm: String) {
        name = .recordForm
        self.recordForForm = recordForForm
        self.historyDateForForm = historyDateForForm
    }
}

struct ExerciseNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case manage
        case select
        case edit
        case add1
        case add2
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var id: Int { name.hashValue }
    let name: Name
    var edit: ExerciseV? = nil
    var exerciseName: String? = nil
    var exerciseParts: [ExerciseV.Part] = []
    
    init(name: Name) {
        self.name = name
    }
    
    init(edit: ExerciseV) {
        name = .edit
        self.edit = edit
    }
    
    init(exerciseName: String, exerciseParts: [ExerciseV.Part]) {
        self.exerciseName = exerciseName
        self.exerciseParts = exerciseParts
        name = .add2
    }
}
